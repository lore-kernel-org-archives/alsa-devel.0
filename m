From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: Recurring VIA8235 SPDIF problems
Date: Tue, 22 Apr 2003 23:47:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304222347.40959.adq_dvb@lidskialf.net>
References: <200304130101.24708.adq_dvb@lidskialf.net> <200304141837.27709.adq_dvb@lidskialf.net> <200304141918.06278.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304141918.06278.adq_dvb@lidskialf.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


> OK, a couple of reboots later, and SPDIF out is on again... but its still
> very very quiet. I cannot seem to find any controls for modifying the
> volume of data going out over SPDIF.. does that even make sense? I'm not
> sure where the SPDIF samples the data.

And once more it dies. This is not a mixer or configuration problem, it has to 
be a driver issue.

Its like SPDIF is enabled, but "something" on the card to do with SPDIF output 
is NOT being enabled at random so the output my receiver receives is very 
very low... 

If I unload and reload the driver lots of times, it tends to eventually work.

Anyone got any ideas where I can start debugging this? Theres no error output 
in syslog.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
