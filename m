From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Linux Kernel-3.5 crashed as dapm is not supported
	by codec
Date: Wed, 7 Nov 2012 11:02:21 +0530
Message-ID: <5099F265.6010008@st.com>
References: <505AFB0B.7010306@st.com>
 <20120920114951.GJ17666@opensource.wolfsonmicro.com>
 <505BE5BB.5010008@st.com> <5098E929.7040404@st.com>
 <20121106114323.GD10080@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog115.obsmtp.com (eu1sys200aog115.obsmtp.com
 [207.126.144.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 671B3264F0B
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 06:32:28 +0100 (CET)
In-Reply-To: <20121106114323.GD10080@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 11/6/2012 5:13 PM, Mark Brown wrote:
> On Tue, Nov 06, 2012 at 04:10:41PM +0530, Rajeev kumar wrote:
>
>> Once again I am raising this issue. Sorry for that.
>> First time I have implemented dapm support for my codec driver
>> (sta529), but still crash is there. There is no any asynchronous
>> events, so platform/Machine driver does not contains any dapm
>> widgets.
>
> This is probably a bug in your system given that nobody else is seeing
> it, I'd suggest you follow normal debugging processes to figure out
> where the crash is occuring.  Just a backtrace isn't really enough to
> provide useful diagnostic information (especially without the
> translation to line numbers), you should at least turn on logging and
> also translate the backtrace into line numbers.
>

Turn on logging does not helping in giving any extra information in this 
case. Backtracing the code gives me the line number. Please find below 
the information.

The problem occur only when I want to put system into hibernation 
otherwise it is working fine.
When the system put into hibernation mode snd_soc_dapm_shutdown  routine 
is called from snd_soc_poweroff function.

static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
3540 {
3541         struct snd_soc_dapm_widget *w;
3542         LIST_HEAD(down_list);
3543         int powerdown = 0;
3544
3545         list_for_each_entry(w, &dapm->card->widgets, list) {
3546                 if (w->dapm != dapm)
3547                         continue;
3548                 if (w->power) {
3549                         dapm_seq_insert(w, &down_list, false);
3550                         w->power = 0;
3551                         powerdown = 1;
3552                 }
3553         }


If you check line number 3545, it is trying to get widget from card.
and the system get crashed as there is no entry for dapm in the card.

As I mentioned previously, I have provided widgets support only at codec 
level not at platform/machine level. So extracting widgets from card may 
create an issue.

Note:
Just to make an experiment, I have added a single widget in machine 
driver then also I am getting the same crash log.

>>
>> Please find below the implementation for dapm.
>>
>> static const struct snd_soc_dapm_widget sta529_dapm_widgets[] = {
>>          SND_SOC_DAPM_DAC("DAC", "Play", SND_SOC_NOPM , 0, 0),
>>          SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
>>          SND_SOC_DAPM_OUTPUT("HPL"),
>>          SND_SOC_DAPM_OUTPUT("HPR"),
>>          SND_SOC_DAPM_OUTPUT("SPKL"),
>>          SND_SOC_DAPM_OUTPUT("SPKR"),
>>          SND_SOC_DAPM_INPUT("MIC1"),
>> };
>
> Does the device really have no power control at all?

I have a single bit for power bridge ONN/OFF in a given register. I am 
handling this bit with  SND_SOC_BIAS_OFF and SND_SOC_BIAS_ON.

Best Regards
Rajeev
