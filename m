From: MNTGE <mntge@indra.es>
Subject: Re: Hammerfall channel/device routing
Date: Thu, 4 Apr 2002 08:41:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a8gt6j$mau$2@main.gmane.org>
References: <20020403015708.92522.qmail@web11503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020403015708.92522.qmail@web11503.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: kevine@esm.rochester.edu, Kevin Ernste <kevine88@yahoo.com>, alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed 03 Apr 2002 03:57, Kevin Ernste wrote:
> Hello -
>
> I am running a Hammerfall 9652 in Alsa 0.9beta11 (under Madrake 8.1) and
> I am
> looking for information about how to route to the varous output channels
> from
> the command line (say, with ecasoubd or aplay).  Right now, sound goes
> to EVERY
> channel (8 ADAT channels, AND the coaxial/SPDIF stereo).
>
> I would like to be able to route sounds separately, as the ADAT channels
> go to
> an ADAT deck (limted to 48k), while the coaxial/SPDIF line goes to
> converters
> which can handle 96k.  I would love to be able to do both.

You are suffering from an erroneous decision of ALSA team when it was changed 
a feature of the PCM API (0.4 to 0.5 transition): file descriptors were 
bounded up with channels, now is bounded up with cards.

Separate operation on multichannel card is easy at application level. 
However, low-level operations (i.e. routing) for each channel at kernel level 
is unnecessary complex.

Regards,
