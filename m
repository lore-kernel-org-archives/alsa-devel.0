From: Michael Ashton <data@ieee.org>
Subject: Re: Number of subdevices on midi.
Date: Thu, 4 Apr 2002 00:17:22 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020404071721.NFBG29627.lakemtao01.cox.net@there>
References: <3CAB5699.1927A89D@ufh.se>
Reply-To: data@ieee.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
In-Reply-To: <3CAB5699.1927A89D@ufh.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 03 April 2002 12:23 pm, you wrote:
> subdevices per device. I need to see the driver for a midi interface
> that using all the
> 16 subdevices. Since I don't get answer from Jaroslav i guess he don't
> have the time
> or my question is stupid. But can someone help me out? Where should I
> look?

I have done a little work on a driver I'm writing for a PCI-MIDI interface 
system I designed (card is built and seems to work, breakout box isn't built 
yet). I first used the MTP-AV driver as a model, but had quite a time 
figuring out how exactly it hooked up with the sequencer, and eventually 
decided to write a kernel sequencer client that talks to the card directly. 
Much easier, and I can add some interesting features using user packets, and 
also I think it will be faster. This does have the disadvantage of leaving 
rawmidi apps in the cold, though, so I'd be interested in whatever you come 
up with.

cheers -- Michael Ashton <data@ieee.org>
