From: Frank Barknecht <barknech@ph-cip.uni-koeln.de>
Subject: Re: [ANNOUNCE] aconnectgui
Date: Thu, 7 Mar 2002 17:10:06 +0100
Message-ID: <a6861m$jmn$1@quimby2.netfonds.no>
References: <20020307122358.089de45a.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020307122358.089de45a.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

Maarten de Boer hat gesagt: // Maarten de Boer wrote:

> "aconnectgui is a FLTK based frontend for aconnect. It is written
> directly on top of the aconnect source, leaving the original source
> intact, only adding a couple of ifdefs, and some calls to the gui
> part, so it provides exactly the same functionality, but with a
> graphical userinterface."
> 
> http://www.iua.upf.es/~mdeboer/
> 
> Note that this is a (quick) port to alsa 0.9.x . I wrote this originally
> for alsa 0.5, when it was called aseqpatchbay. I currently don't have a
> soundcard with any interesting MIDI devices, so I would apreciate if
> you let me know if it works for you. 
You don't need real soundcards, you can play with the snd-virmidi module
and create as much virtual midi devices as you like. I have a problem with
aconnectgui, that it overlays my cards. I have two real soundcards, one of
it is a SBLive which has the Emu-Synth. And I have a virtual midi card,
that adds four more ports to the list. I can not see the virtual ports 2-1
and 2-2, because the four Emu10k1 ports are shown above the virtual ports.
I think this might be a layout problem. This seems to disturb the
application, as I can't make any connections, duh. It does show
connections, that were created in advance with aconnect, though. 

But I like the idea of aconnectgui, and I think it would be appropriat, to
add it to my 'aconnect-Howto', that might appear on DLP's Sound and Midi
page soon...
-- 
                                                 __    __
 Frank Barknecht       ____ ______   ____ __ trip\ \  / /wire ______
                      / __// __  /__/ __// // __  \ \/ /  __ \\  ___\	
                     / /  / ____/  / /  / // ____// /\ \\  ___\\____ \	
                    /_/  /_____/  /_/  /_//_____// /  \ \\_____\\_____\
                                                /_/    \_\ 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
