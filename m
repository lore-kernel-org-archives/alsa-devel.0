From: Paul Davis <pbd@op.net>
Subject: Re: Hammerfall channel/device routing
Date: Wed, 03 Apr 2002 11:17:43 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a8fdhf$v1k$2@main.gmane.org>
References: <20020403015708.92522.qmail@web11503.mail.yahoo.com>
In-Reply-To: Your message of "Tue, 02 Apr 2002 17:57:08 PST."
             <20020403015708.92522.qmail@web11503.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: kevine@esm.rochester.edu
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>I am running a Hammerfall 9652 in Alsa 0.9beta11 (under Madrake 8.1) and I am
>looking for information about how to route to the varous output channels from
>the command line (say, with ecasoubd or aplay).  Right now, sound goes to EVER
>Y
>channel (8 ADAT channels, AND the coaxial/SPDIF stereo).  
>
>I would like to be able to route sounds separately, as the ADAT channels go to
>an ADAT deck (limted to 48k), while the coaxial/SPDIF line goes to converters
>which can handle 96k.  I would love to be able to do both.

i would love to be able to answer you (as the driver author), but this
is not at all a hammerfall specific question, and the answer is not
well documented at this time. the method is the same for all ALSA
supported devices.

if you search the archives for "ttable" you will get some clues. i am
sure that others who have done this will be able to give you better
answers.

--p
