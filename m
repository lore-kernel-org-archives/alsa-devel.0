From: "Christophe Osuna" <christophe.osuna@gmail.com>
Subject: Re: Problem to compile : Undefined reference
Date: Thu, 1 Mar 2007 08:58:02 +0100
Message-ID: <b6251a620702282358o71d12d7cg282f4b7cb1a0a37@mail.gmail.com>
References: <50fdad60702280603v63503c8o78dd71b5872fc0c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <50fdad60702280603v63503c8o78dd71b5872fc0c0@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Nyx <keres.nyx@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

2007/2/28, Nyx <keres.nyx@gmail.com>:
> I want to develop some applications (VUmeter and Peakmeter) with
> ALSA-API. So, I tried to compile an example from
> http://equalarea.com/paul/alsa-audio.html#playex but I have some
> errors like : "
> example.o(.text+0x30c): In function `main':
> : undefined reference to `snd_strerror'
> example.o(.text+0x340): In function `main':
> : undefined reference to `snd_pcm_close'
> [..]"
>
> Do you have an idea where these errors come from ?

You have to link your program with the ALSA library. For instance:

  gcc -lasound -Wall -o myprog myprog.c

Of course, ALSA development files must be installed.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
