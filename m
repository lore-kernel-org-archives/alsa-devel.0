From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: The ALSA Situation
Date: Thu, 11 Nov 2004 19:52:47 -0300
Message-ID: <1100213567.2076.29.camel@localhost>
References: <200411102113.iAALDLUN001061@localhost.localdomain>
	 <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411110714280.2179@pnote.perex-int.cz>
	 <Pine.LNX.4.58.0411102241240.2301@ppc970.osdl.org>
	 <s5his8cfiot.wl@alsa2.suse.de>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5his8cfiot.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, 2004-11-11 at 17:34 +0100, Takashi Iwai wrote:
> At Wed, 10 Nov 2004 22:42:20 -0800 (PST),
> Linus Torvalds wrote:
> > 
> > On Thu, 11 Nov 2004, Jaroslav Kysela wrote:
> > > 
> > > Unfortunately, the application will have to settle other real-time
> > > parameters (including stream parameters, i/o chunk sizes etc.), so we must
> > > drain on close() the complete stream and not allow intermixing requests
> > > from applications.
> > 
> > That seems to be a misdesign of the interfaces, but whatever.
> 
> Well, the contiguous use of a stream isn't easy as it sounds.
> Since each app wants different buffer size, period (fragment) size,
> sample format, sample rate etc, the configuration must be reset
> totally at each time.  This eventually requires to stop of the DMA.

There 2 situations (AFAIK): 

1) * Stinking intel8x0 or similar card with only one stereo stream:
  - Device should be accessed as 48KHz 16 bit stereo (highest quality
available), since it most probably does not even have a samplerate
converter. There should be no concern about latency/buffer size, thats
just silly in such a kind of device. Just use the most efficient DMA
setup.
  - All applications using the device should be softmixed. It does not
make any sense to give direct access to applications.

2) * Multichannel card:
  - Use one channel for softmixing (reserved for ever for that purpose,
at highest audio quality). Just the same as for the single channel card.
  - Use a "Resource Manager" that assigns hardware channels as are
available, and choose the softmixing engine coupled to the reserved
channel when we get out of hardware channels.
   - If we want to make this even nicer, and thinking in the future
where hardware channels may have (they actually have, but are not
supported) advanced processing features, the "Resource Manager" could
assign hardware channels on behalf of the features the applications asks
for. For example if a application does not ask for HRTF processing, give
it a softmixing channel, or  a hardware channel lacking that feature.

As you can see, both situations are in essence the same, as if there is
only one hardware channel, after reserving the softmixing channel, you
got out of hardware channels, falling into the same situation as of a
multichannel device with all hardware channels being used.

That is my dream of a sound API behaviour. In 1996 they called that
A3D... so this ideas aren't quite new :P

Best Regards

-- 
Manuel Jander
Electronic Engineer



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
