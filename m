From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Hardware interface constant for Bluetooth
Date: Mon, 08 Nov 2004 13:28:12 +0100
Message-ID: <1099916892.6896.122.camel@pegasus>
References: <1099877050.6896.70.camel@pegasus>
	 <Pine.LNX.4.58.0411081152120.2162@pnote.perex-int.cz>
	 <1099915428.6896.107.camel@pegasus>
	 <Pine.LNX.4.58.0411081305260.2162@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411081305260.2162@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

> > this is a little bit tricky. Besides the native support for transporting
> > PCM data over a Bluetooth SCO channel, the headset/handsfree profile
> > uses a RFCOMM channel (serial port emulation) for additional settings.
> > On this channel they use AT commands and actually I don't wanna put a AT
> > parser into the kernel. It is in somekind possible, but I still think
> > that it does not belong there, because it is profile specific and a
> > Bluetooth profile is an application and applications should run in user
> > space. On the other hand you still need to create that SCO channel from
> > user space with somekind of ioctl, because the kernel can't know when
> > this channel must be established. It depends on some AT commands that
> > are send over the RFCOMM channel.
> > 
> > So my plan is to write a kernel module that is reponsible for the SCO
> > audio traffic. This registers as a soundcard with the ALSA subsystem and
> > it also registers a Bluetooth HWDEP. There is no initial PCM device
> > registered with this soundcard. These are only added when a SCO channel
> > is opened from the peer side or requested through an ioctl on the HWDEP
> > interface. Besides this the HWDEP would also control the mixer settings,
> > because these are exchanged over the RFCOMM channel.
> > 
> > Do you think this makes sense?
> 
> Yep, the management of PCM devices belongs into the hwdep API - except the
> mixer controls. You should map the possible mixer and other controls using
> the universal control API.
> 
> The SNDRV_HWDEP_IFACE_BLUETOOTH definition was added to the ALSA CVS tree.

I will look at the universal control API when the basics of the PCM
handling are done. Thanks.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
