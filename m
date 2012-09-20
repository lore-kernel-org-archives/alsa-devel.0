From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Audio codec volume control
Date: Thu, 20 Sep 2012 16:09:53 +0530
Message-ID: <505AF279.9050906@st.com>
References: <505ACC37.3060209@st.com> <505AE8C6.3040001@ti.com>
 <505AEB19.7080205@st.com> <505AED95.20400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
 [207.126.144.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 89B212652C0
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 12:40:01 +0200 (CEST)
In-Reply-To: <505AED95.20400@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello Peter,

On 9/20/2012 3:49 PM, Peter Ujfalusi wrote:
> On 09/20/2012 01:08 PM, Rajeev kumar wrote:
>>> case 3:
>>> 1. Provide master volume control
>>> 2. stereo volume control for the left/right channel
>>>
>>
>> You mean to say
>> Left and Right should be a single stereo control which can be provided with
>> SOC_DOUBLE. Actually case 2 corresponds to the same setting which you are
>> suggesting.
>>
>> But why this is better option?
>
> You have less controls for the codec ->  easier for users.
> Users still can adjust the left/right differently if they want.
>
>> In case user wants a separate left/right volume control then how this setting
>> is going to help.
>
> In most cases you change both left/right channel:
> amixer sset 'PCM' 8 # left/right volume is 8
>
> but users can set different volume per channel:
> amixer sset 'PCM' 8,1 # left volume is 8, right is 1
>
> it is better than:
> amixer sset 'PCM Left' 8 # left volume is 8
> amixer sset 'PCM Right' 8 # left volume is 8
>
> or
> amixer sset 'PCM Left' 8 # left volume is 8
> amixer sset 'PCM Right' 1 # left volume is 1
>

Thanks for the info.

Please find below the controls I have provided

static const char *pwm_mode_text[] = { "Binary", "Headphone", "Ternary",
         "Phase-shift"};

static const DECLARE_TLV_DB_SCALE(out_gain_tlv, -9150, 50, 0);
static const DECLARE_TLV_DB_SCALE(master_vol_tlv, -12750, 50, 0);
static const SOC_ENUM_SINGLE_DECL(pwm_src, STA529_FFXCFG1, 4, 
pwm_mode_text);

static const struct snd_kcontrol_new sta529_snd_controls[] = {
         SOC_DOUBLE_R_TLV("Digital Playback Volume", STA529_LVOL, 
STA529_RVOL, 0,
                         127, 0, out_gain_tlv),
         SOC_SINGLE_TLV("Master Playback Volume", STA529_MVOL, 0, 127, 1,
                         master_vol_tlv),
         SOC_ENUM("PWM Select", pwm_src),
};

So in our amixer output I am not getting any separate numid for 
left/right volume, so that user can control it.

Is there something I am missing in my code.


Best Regards
Rajeev
