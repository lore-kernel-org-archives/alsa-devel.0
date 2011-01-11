From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: HDA - hdmi_show_short_audio_desc puts wrong rates
 in	eld#N
Date: Tue, 11 Jan 2011 19:25:55 +0200
Message-ID: <4D2C92A3.6020800@iki.fi>
References: <4CFE13FE.5070703@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
	[83.102.40.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A63F61037F9
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 18:25:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sinikuusama.dnainternet.net (Postfix) with ESMTP id 2DEE62C943
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 19:25:57 +0200 (EET)
Received: from sinikuusama.dnainternet.net ([83.102.40.134])
	by localhost (sinikuusama.dnainternet.net [127.0.0.1]) (amavisd-new,
	port 10041)
	with ESMTP id kXBVNDkLZwOx for <alsa-devel@alsa-project.org>;
	Tue, 11 Jan 2011 19:25:57 +0200 (EET)
Received: from kirsikkapuu.dnainternet.net (kirsikkapuu.dnainternet.net
	[83.102.40.214])
	by sinikuusama.dnainternet.net (Postfix) with ESMTP id 02B7D2C93F
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 19:25:57 +0200 (EET)
Received: from mail.onse.fi (unknown [109.204.162.131])
	by kirsikkapuu.dnainternet.net (Postfix) with ESMTP id E9D532BB30
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 19:25:55 +0200 (EET)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id A99362080EE
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 19:25:55 +0200 (EET)
In-Reply-To: <4CFE13FE.5070703@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07.12.2010 13:01, Anssi Hannula wrote:
> Hi!
> 
> Just noticed that the sample rates reported in eld#X.Y are wrong.
> 
> They are printed by hdmi_show_short_audio_desc() in hda_eld.c. That
> function uses the snd_print_pcm_rates() function to convert the rates
> bitmap to a string. However, snd_print_pcm_rates() takes a HDA rates
> bitmap, not a generic SNDRV_ one.  (BTW, an interesting function name
> for an internal HDA thing...)
> 
> This results in several errors.
> 
> For example, my 32000 44100 48000 88200 96000 176400 192000
> becomes 44100 48000 88200 176400 192000 384000.

In case I write a patch for this, is there a preferred approach?

(a) Add a function into alsa core that returns such a list string when
given a rates bitmap, or

(b) export the rates array in core and make the string-giving function a
static one for hda_eld.c, or

(c) add a static function into hda_eld.c that parses the bitmap manually
by checking it for all the hdmi rates (7 IIRC).

-- 
Anssi Hannula
