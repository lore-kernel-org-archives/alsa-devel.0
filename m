From: Patrick Shirkey <kotau@firstlinux.net>
Subject: Re: stupid question about pcm devices
Date: Thu, 7 Feb 2002 22:43:10 -0800 (PST)
Message-ID: <20020208064310.40B1B3ECC@sitemail.everyone.net>
Reply-To: pshirkey@boosthardware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guenther Sohler <guenther.sohler@newlogic.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org




--- Guenther Sohler <guenther.sohler@newlogic.com> wrote:
>I have seen that alsa provides nice pcm devices in /dev/snd directory
>
>*They are split in playback and capture devices :) nice idea.
>In Oss I was able to pipe data from and to them and therfore was
>recording/playing back at a certain sample rate.
>With alsa this is not possible anymore. it says the descriptor was in a bad
>state. Is it possible ???
>
>*Is there something like aconnect for pcm devices ????
>

That is on it's way but is part of the jack api. 

checkout http://jackit.sourceforge.net




>when I do a sfxload, it operates on /dev/sequencer, which makes the seq-oss
>module automatically to load. Is there a way to load the patches in native alsa
>???
>
>rds guenther
>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel


--
Patrick Shirkey - Boost Hardware Ltd
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/Linux_Audio_Users_Guide/


_____________________________________________________________
Want a new web-based email account ? ---> http://www.firstlinux.net

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
