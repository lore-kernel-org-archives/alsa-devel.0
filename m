From: "samuelchemla@orange.fr" <samuelchemla@orange.fr>
Subject: Re: ALSA HDMI output not detected
Date: Thu, 23 Oct 2014 22:44:10 +0200
Message-ID: <5449689A.20806@orange.fr>
References: <5447ED92.1090403@orange.fr> <s5h8uk6yd8f.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 783A0260477
 for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2014 22:44:12 +0200 (CEST)
In-Reply-To: <s5h8uk6yd8f.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

there is no ELD file in /proc/asound nor /proc/asound/card0
On the EDID side, do you mean any EDID from any HDMI screen ?
I thought EDID file was screen dependant.
I know the screen is HDMI sound capable because I am using it with a 
raspberry without problem... :-)

Regards,
Sam

On 23/10/2014 18:14, Takashi Iwai wrote:
> At Wed, 22 Oct 2014 19:46:58 +0200,
> samuelchemla@orange.fr wrote:
>> Hi guys,
>>
>> I opened a bug about HDMI sound output not detected on an NVIDIA optimus
>> laptop.
>> I don't know if HDMI sound card detection is up to ALSA, the kernel or
>> the video driver.
> Actually all of three are involved fairly tightly.
>
>> Could anyone give me a clue so the bug can be routed to its correct
>> destination?
>> Link to the bug:
>> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1377653
> You should start checking EDID on the video side and ELD on the audio
> side.  ALSA driver shows the connection and ELD status in proc files
> and control elements.  If EDID is given, but ELD (or monitor
> connection state) isn't, usually it's a video driver problem, e.g. the
> audio register bit isn't set properly.
>
>
> Takashi
