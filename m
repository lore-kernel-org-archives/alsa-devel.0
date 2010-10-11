From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Alsamixer-Qt4 0.5.0 released
Date: Mon, 11 Oct 2010 15:18:20 +0200
Message-ID: <4CB30E9C.2030100@gmx.de>
References: <4CB0D360.2010201@gmx.de>
	<AANLkTik0dkK=otsWQKEf2x2ViQ7Gup_pzCj2V4e0yqkD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 18540103942
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 15:20:29 +0200 (CEST)
In-Reply-To: <AANLkTik0dkK=otsWQKEf2x2ViQ7Gup_pzCj2V4e0yqkD@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Niels Mayer <nielsmayer@gmail.com>
Cc: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, linux-audio-user <linux-audio-user@lists.linuxaudio.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 10.10.2010 23:20, schrieb Niels Mayer:
> On Sat, Oct 9, 2010 at 1:41 PM, Sebastian H. <vand2@gmx.de> wrote:
>> ( http://xwmw.org/alsamixer-qt4/ )
>> After an almost complete rewrite to support separate channels views
>> in the main sliders and switches areas, Alsamixer-Qt4 0.5.0 is now
>> available.
> 
> This is a vast improvement over the previous version for those with
> envy24-based cards where the previous separate channel views were
> problematic ( http://www.spinics.net/linux/lists/alsa-devel/msg36494.html
> ).
> 
> Here's how this latest alsamixer-qt4 looks against the equivalent
> controlpanels from http://mudita24.googlecode.com (svn trunk edition):
> http://nielsmayer.com/envy24control/alsamixer-qt4-playback-envy24.png
> http://nielsmayer.com/envy24control/alsamixer-qt4-capture-envy24.png

Great, thank you for the screenshots. Everything looks good so far.
The free space after the rightmost playback slider bothered me a bit.
But that's due to the long label text of the slast slider.
And admitted, your envy24 mixer with the nice peak meters and the
dB labels looks a bit more professional. ;)

> One thing that takes getting used to: the controls that are "muted" in
> envy24control/mudita24 are unchecked in alsamixer-qt4 -- the active or
> captured channels are the ones showing the checkbox selection.

There're some mixer where one has to activate a switch to mute
the volume. I always found this counter intuitive.
If it were real switch that mutes a channel it may make sense.
But if something is glowing I would assume it to be *on*.
Maybe like the status LED beside the real mute switch.


Sebastian
