From: Chuck Busby <scarecrow.143@attbi.com>
Subject: Re: Separating left/right channels (voices)
Date: Sat, 6 Apr 2002 15:57:52 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020407000619.DKAM15826.rwcrmhc54.attbi.com@there>
References: <20020406132739.U83199-100000@flex.com>
Reply-To: scarecrow.143@attbi.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020406132739.U83199-100000@flex.com>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 06 April 2002 03:37 pm, you wrote:
> Hi all,
>
> I am working on a problem where I want to extract the left and right
> channels from a sound file.  I am running into a problem where I can not
> tell if the samples are from the left only, or the right only channels.
> I have a sound file that is mono, when I play this file through ALSA, the
> samples come out on both left and right speakers.  It seems either ALSA is
> sending the mono samples to both channels, or my soundcard is doing it.
> I am wondering if there is a way to control whether a mono sound file can
> be played to only one speaker using ALSA.
>
> Also, does anyone have a sound file that has one song on the left channel
> and another song on the right channel?  Does anyone know how to generate
> such a file from two mono files?
>
You could do this using audacity
http://audacity.sourceforge.net/

> Any help is greatly appreciated.
>
> --jc
>
> P.S.  I might be confusing the terms 'channels' and 'voices'.  I know some
> people and tools use them differently.  Basically, I am using the term
> 'channels' to mean the left and right parts of a file with stereo samples.

- -- 
Chuck Busby
scarecrow.143@attbi.com
- --
Any technology which is discernable from Magick is not sufficiently advanced.
Arthur C. Clarke
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8r4uG6QsBUxz29H8RAic0AKCsg7h98nvYq6O3xV0kYcr9yL8zKACgnx09
Gczn5z9Z/Mboc8cLFb/40zA=
=OfCM
-----END PGP SIGNATURE-----
