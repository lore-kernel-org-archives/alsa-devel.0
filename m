From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF and cs46xx ?
Date: Fri, 04 Apr 2003 20:01:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E8DC881.2070401@cucumelo.org>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net> <3E75075E.7030401@cucumelo.org> <20030329142035.GA16590@ulima.unil.ch> <3E864424.6060707@cucumelo.org> <20030330144633.GA9474@ulima.unil.ch> <20030331114752.GA3187@wotan.suse.de> <20030404114623.GB9836@ulima.unil.ch>
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
Cc: "Dr. Werner Fink" <werner@suse.de>, Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>sorry to ask again :-(
>I have just installed latest alsa CVS of drivers,lib and utils and still
>get a:
>
>pr  4 13:37:43 localhost vdr[20035]: S/P-DIF: Period size not available: Invalid argument
>Apr  4 13:37:43 localhost vdr[20035]: S/P-DIF: unable to establish BitStreamOut for none audio PCM 
>Apr  4 13:37:43 localhost vdr[20035]: REPLAY: can't open spdif interface
>
>Should I change anything anywhere?
>Or buy a card with cmipci? (Well I like the Digifire 7.1 I have now,
>which has also an integrated Firewire...).
>  
>
I would like to get to the bottom of this problem.
Let's try figure out exactly which lines of code produces thoose 
messages: "S/P-DIF: Period size not available: Invalid argument" and 
"S/P-DIF: unable to establish BitStreamOut for none audio PCM"

/Benny



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
