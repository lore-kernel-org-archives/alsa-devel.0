From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] alsaloop: Correct check in if condition
Date: Mon, 23 Jan 2017 12:08:47 +0100
Message-ID: <caf13bb7-1481-1328-163f-68c3eb80abb7@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@mailman.alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date: Mon, 23 Jan 2017 11:45:13 +0100

Fix the error below found by gcc (Debian 6.3.0-4) 6.3.0 20170121.

```
gcc -DHAVE_CONFIG_H -I. -I../include  -I../include  -D_GNU_SOURCE -O2 
-Wall -pipe -g -MT pcmjob.o -MD -MP -MF .deps/pcmjob.Tpo -c -o pcmjob.o 
pcmjob.c
pcmjob.c: In function 'pcmjob_start':
pcmjob.c:1482:27: warning: self-comparison always evaluates to true 
[-Wtautological-compare]
       loop->play->channels == loop->play->channels &&
                            ^~
```

Judging from the surrounding code, the check should make sure the
channels of the play and capture device are equal.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
I hope, this patch gets through without any mangling from Mozilla 
Thunderbird.

  alsaloop/pcmjob.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/alsaloop/pcmjob.c b/alsaloop/pcmjob.c
index 4df59e8..2be0732 100644
--- a/alsaloop/pcmjob.c
+++ b/alsaloop/pcmjob.c
@@ -1479,7 +1479,7 @@ __again:
  	if (loop->play->access == loop->capt->access &&
  	    loop->play->format == loop->capt->format &&
  	    loop->play->rate == loop->capt->rate &&
-	    loop->play->channels == loop->play->channels &&
+	    loop->play->channels == loop->capt->channels &&
  	    loop->sync != SYNC_TYPE_SAMPLERATE) {
  		if (verbose > 1)
  			snd_output_printf(loop->output, "shared buffer!!!\n");
-- 
2.4.1
