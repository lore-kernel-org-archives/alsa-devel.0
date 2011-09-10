From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: problem with RME DSP MADI,
 kernel 2.6.38 and hdspmixer from git
Date: Sat, 10 Sep 2011 10:10:30 +0200
Message-ID: <4E6B1B76.7010303@drcomp.erfurt.thur.de>
References: <59A59943-F67D-4ACD-94E5-95987CC46796@resorama.com>	<20110908150911.GU9510@ltw.loris.tv>	<0A02B5E2-4D1B-4445-B9F2-B4876CC8EEB2@resorama.com>	<3BBC0003-F165-4994-8950-CC7CF24FDD6C@resorama.com>
	<4E6A8440.9090000@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id E774524403
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Sep 2011 10:10:45 +0200 (CEST)
In-Reply-To: <4E6A8440.9090000@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maarten de Boer <maarten@resorama.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Natanael Olaiz <natanael.olaiz@immsound.com>, Pau Arumi <pau.arumi@immsound.com>
List-Id: alsa-devel@alsa-project.org

On 09/09/11 23:25, Adrian Knoth wrote:

>>  * hdspmixer is now working without modification, but I get the
>>  impression it does set up more routing than what I can control in the
>>  interface, specifically concerning the analog output:
> 
> This is clearly a bug. The code in HDSPMixerCard.cxx says
> 
>             channels_input = channels_playback = 64;
>             channels_output = channels_input; /* SS headphones missing,
> at least HDSPe MADI has some, MADIface hasn't */
> 
> 
> You could set channels_output to 66. You might need to change
> HDSP_MAX_CHANNELS to 66, but try HDSP_MAX_DEST to 33 in defines.h,
> first. (changing HDSP_MAX_CHANNELS has some more implications)
> 
> Then, change dest_map_unity[32] to dest_map_unity[HDSP_MAX_DEST] in
> channelmap.h and the same in channelmap.cxx. Then, add the missing
> channel number. Which one to choose? No idea. Try 64. If it's the wrong
> on, try every even number up to 128.

Forget all this, as I just learned, monitor out is 63/64.

I don't know how familiar you are with hdspmixer, if in doubt, consult
the README.

What you might want to do: activate submix mode (either by pressing S or
clicking on the appropriate menu items), then choose "63+64" below an
input or playback fader, thus changing all faders to operate on 63+64.
Adjust according to your needs.


HTH
