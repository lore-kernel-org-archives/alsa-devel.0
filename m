From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF and cs46xx ?
Date: Sun, 30 Mar 2003 03:11:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E864424.6060707@cucumelo.org>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net> <3E75075E.7030401@cucumelo.org> <20030329142035.GA16590@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net, werner@suse.de
List-Id: alsa-devel@alsa-project.org

>
>
>And is there any hope of any enhancement?
>I "need" the SPDIF of my Digifire 7.1 to be able to use the bitstreamout
>plugin of VDR made by Dr. Werner Fink
>(https://sourceforge.net/projects/bitstreamout/) because as he wrote the
>SPDIF out of my DVB card is not "good":
>
>"As long as the hardware on the DVB cards are not able to put
>the 16bit none audio PCM data stream into a 32bit none audio
>S/P-DIF transport stream all receivers which uses the bit flags
>of the S/P-DIF transport stream for identifying none audio
>loose.  All S/P-DIF data get from the DVB card to not have the
>none audio bit set.  AFAIK this is a hardware bug (or better
>this is the information I've got from TT) ..."
>
>But when I try the plugin I got:
>
>Mar 29 15:15:17 localhost vdr[9090]: S/P-DIF: Period size not available: Invalid argument
>Mar 29 15:15:17 localhost vdr[9090]: S/P-DIF: unable to establish BitStreamOut for none audio PCM 
>Mar 29 15:15:17 localhost vdr[9090]: REPLAY: can't open spdif interface
>
>  
>
Seems like a user application problem to me.  The cs46xx driver just 
support a limited set of period-size configurations, that's a limitation 
in the HW. Then it's up to the application to handle it (I guess)
I've managed to make AC3 and DTS through SPDIF work witth OGLE and Xine, 
I dont see any reason why it would'nt work with any other application, 
at least you should get further than: "S/P-DIF: Period size not 
available: Invalid argument" then when you've managed to open the device 
and write data to it maybe there will apear other unknown problems ...

/Benny



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
