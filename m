From: Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH] Provide card number / PID
	via	sequencer	client info
Date: Wed, 17 Feb 2016 22:30:54 +0100
Message-ID: <20160217213054.GA5144@mail.zuhause>
References: <20160215183243.GA26482@mail.zuhause>
 <s5hziv194gz.wl-tiwai@suse.de>
 <20160215214454.GA11052@mail.zuhause>
 <s5hsi0t8uxq.wl-tiwai@suse.de>
 <20160216080334.GA15116@mail.zuhause>
 <s5hio1p82t6.wl-tiwai@suse.de> <56C2E4F9.6030204@ladisch.de>
 <s5hegcd80p3.wl-tiwai@suse.de>
 <20160216182137.GA21791@mail.zuhause>
 <s5h7fi34ehu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe01-3.mx.upcmail.net
 (vie01a-dmta-pe01-3.mx.upcmail.net [62.179.121.156])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B041260509
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 22:30:58 +0100 (CET)
Received: from [172.31.216.43] (helo=vie01a-pemc-psmtp-pe01)
 by vie01a-dmta-pe01.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1aW9gY-0004uY-Dk
 for alsa-devel@alsa-project.org; Wed, 17 Feb 2016 22:30:58 +0100
Content-Disposition: inline
In-Reply-To: <s5h7fi34ehu.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Martin Koegler <martin.koegler@chello.at>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2016 at 03:07:25PM +0100, Takashi Iwai wrote:
> > My users are using a few identical USB MIDI keyboards [or USB MIDI interfaces] and
> > I need to recognize the devices even after reboot. 
> > 
> > => I want a stable, unique (composite) device ID for kernel sequencer clients+ports.
> > 
> > My current ID is: client name, sysfs-path and port number.
> > 
> > The sound card number allows to find the device in sysfs and determine the used USB port as stable identifier.
> > I hope, that the registration order for the ports of one USB MIDI device [or sound card] will always be the same.
> > 
> > see my prototype: https://build.opensuse.org/package/view_file/home:e9925248:branches:openSUSE:Leap:42.1:Update/grandorgue/0001-Add-support-for-unique-device-IDs.patch?expand=1
> > 
> > OPL3/4 + emuXXX synth register with a different name, so they should be distinct. 
> 
> Yeah, there is a difference, of course.  But the identifying by the
> name string suffices?  In other words, how would user-space identify
> the client at best?  Passing another attribute to client_info like
> port type?

port type is not property of struct snd_seq_client - so it is better reported via port info.
It already has SND_SEQ_PORT_TYPE_SYNTHESIZER and SND_SEQ_PORT_TYPE_PORT.

For my usecase, I don't care about the type.
Either the user select it from a drop-down or uses auto-detection: He triggers at request 
a MIDI event and the port with activity is selected - If you want to see it in action: https://www.youtube.com/watch?v=3g7H1W4x2cg [at 1:20]

> > I just ask myself, if the device index would provide any useful information.
>  
> Which "device index" do you mean?  The index passed at created
> snd_seq_create_kerne_client()?

Yes.

> > I don't know, how to map it to a anything below the soundcard in sysfs. 
> > Is the device ID dymanic? [= Are they depending, if I first load the rawmidi module and then the synth module or the other way around].
> 
> If you mean about the client index offset, then usually they are fixed
> by each driver.  And even the client id number is fixed (up to 4
> clients per card):
>   client = 16 + card * 4 + index.
> 
> So, in most case, the card number can be calculated even without the
> new information.  But, this is rather heuristic, and a clear mapping
> would be better, of course.

The key word is "usually". Its only suitable for an interface, if it is "always" fixed or can be used as an pointer on sysfs.

Regards,
Martin
