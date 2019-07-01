From: <vanitha.channaiah@in.bosch.com>
Subject: GIT: Regarding the issue we are facing in the commit
	37728639ae05de702825d96bd1d42e24ae772248
Date: Mon, 1 Jul 2019 15:58:11 +0530
Message-ID: <1561976891-17886-1-git-send-email-vanitha.channaiah@in.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5298395794099221481=="
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: twischer@de.adit-jv.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============5298395794099221481==
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit


This mail is regarding the fix at below:
commit 37728639ae05de702825d96bd1d42e24ae772248
Author: Jaroslav Kysela <perex@perex.cz>
Date:   Sat Feb 7 15:01:31 2004 +00
The commit has following changes :
 
******************************* code *****************************************
static int snd_pcm_rate_hw_refine_cchange(snd_pcm_t *pcm, snd_pcm_hw_params_t *params,
					  snd_pcm_hw_params_t *sparams)
{

+       buffer_size = snd_pcm_hw_param_get_interval(params, SND_PCM_HW_PARAM_BUFFER_SIZE);
+       /*
+        * this condition probably needs more work:
+        *   in case when the buffer_size is known and we are looking
+        *   for best period_size, we should prefer situation when
+        *   (buffer_size / period_size) * period_size == buffer_size
+        */
+       if (snd_interval_single(buffer_size) && buffer_size->integer) {
+               snd_interval_t *period_size;
+               period_size = (snd_interval_t *)snd_pcm_hw_param_get_interval(params, SND_PCM_HW_PARAM_PERIOD_SIZE);
+               if (!snd_interval_checkempty(period_size) &&
+                   period_size->openmin && period_size->openmax &&
+                   period_size->min + 1 == period_size->max) {
+                       if ((buffer_size->min / period_size->min) * period_size->min == buffer_size->min) {
+                               snd_interval_set_value(period_size, period_size->min);
+                       } else if ((buffer_size->max / period_size->max) * period_size->max == buffer_size->max) {
+                               snd_interval_set_value(period_size, period_size->max);
+                       }
+               }
+       }
}
******************************* code ****************************************
 
Update rate depending on period_size and period_time.
Issue found in Hardware : 
a. RCAR salvator-xs which supports 2 channel.
b. IMX which supports 8 channel.
 
1. Usecase which is PASSED without the mentioned commit and FAILED with the commit.

For the usecase with below command : rate = 11025 channel = 6
 
$aplay -Dentertainment_main -r11025 -c6 -fS16_LE /dev/urandom


a. With the commit:
 
In the calculation of RATE at Rule 7:
RATE=11025
dependent parameters are: 
PERIOD_SIZE=88 PERIOD_TIME=8000
 
parameters		min		max		open_min		open_max		interval

PERIOD_SIZE		88		88		0			0			0
PERIO_TIME		8000		8000		0			0			0
RATE			11025		11000		0			0			1


RATE values are calculated in snd_interval_refine()
Return value:  INVALID as rate_min > rate_max
 
This is because, dependent parameter “period_size” is rounded to 88 in “rate plugin” in snd_pcm_rate_hw_refine_cchange()

Since, the below condition gets satisfied(buffer_size = 352 aligned to period_size = 88), period_size gets rounded to 88.
if ((buffer_size->min / period_size->min) * period_size->min == buffer_size->min) {
 
This commit changes causing the issue to get rate_min > rate_max.

The flow of code execution is as follows:
-   snd_pcm_hw_refine_slave()  
-	Enters snd_pcm_rate_hw_refine_cchange(), rounding of period_size to 88.
-   snd_pcm_rate_hw_refine_cchange() exit.
-   snd_pcm_hw_refine_soft() is called, here exists params->rmask to evaluate for SAMPLE_BITS, FRAME_BITS, PERIOD_BYTES, BUFFER_BYTES
-   execution of RULES calculation.
At RULE 7 rate calculation INVALID error is observed.

b. Without the commit:
In the case if period_size doesn’t get rounded off to 88, the usecase would get PASSED.
Rate calculation goes fine with period_size open interval (88, 89)
 
parameters			min			max			open_min		open_max			interval

PERIOD_SIZE			88			89			0			0				0
PERIOD_TIME			8000			8000			0			0				0
RATE				11025			11025			0			0				1

Here, there is no issue of rate_min > rate_max.
****************************************************************************************************************************************************************
Now, I just have one scenario where with/without commit, rate calculation goes fine.
2. Usecase which is PASSED with and without above commit.
 
For the usecase with below command : rate =11025 channel=2 
$aplay -Dentertainment_main -r11025 -c2 -fS16_LE /dev/urandom 
 
a. Including the above commit code:
Below is the calculation that goes:

The flow of code execution is as follows:
-   snd_pcm_hw_refine_slave()  
-	Enters snd_pcm_rate_hw_refine_cchange() , rounding of period_size to 88.
-   snd_pcm_rate_hw_refine_cchange() exit.
-   snd_pcm_hw_refine_soft() is called, here params->rmask is 0.
-   RULES calculation doesnt occur.

b. Without the commit:
In the case if period_size doesn’t get rounded off to 88.
Rate calculation goes fine with period_size open interval (88, 89)

Is there any dependency for the commit ? If yes, can you please suggest the corner case 
which fails without the commit ?
Can we revert the changes ?

--===============5298395794099221481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5298395794099221481==--
