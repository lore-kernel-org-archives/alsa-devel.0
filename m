From: David Parker <david@neongoat.com>
Subject: Re: Trident problems.
Date: Tue, 9 Sep 2003 13:35:50 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030909133550.0d325254.david@neongoat.com>
References: <20030828005741.162b0565.david@neongoat.com>
	<873cfj82bq.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <873cfj82bq.fsf@sycorax.lbl.gov>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 30 Aug 2003 10:47:37 -0700, Alex Romosan wrote:

> David Parker <david@neongoat.com> writes:
> 
> > A long time ago (many months... sorry I don't know exactly when), my
> > Trident card stopped working with ALSA on a Debian unstable box. It
> > still works with the kernel OSS module, but ALSA has problems with
> > the AC'97 codec. Here's what I tried and the resulting log
> > messages/output:
> >
> > hypnotic:/home/dap# modprobe snd-trident
> > ALSA ../../alsa-kernel/pci/trident/trident_main.c:3394: AC'97 codec ready error
> > Trident 4DWave PCI soundcard not found or device busy
> > devfs_register(unknown): could not append to parent, err: -17
> > ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:2096: AC'97 0:0 does not respond - RESET
> > Trident 4DWave PCI soundcard not found or device busy
> >
> 
> i have exactly the same problem. the weird thing is when it happened
> (many months ago) i tried to go back to the previous working version
> and it still didn't work. my theory is that the ac'97 codec got into a
> funky state and it's not being reset. unfortunately i don't know what
> to do either.

Things have been quiet on this thread... does anyone have any ideas, or any
knowledge of whether or not the ac'97 codec can even get into such a weird
persistent state? Is it something that can be ignored, since somehow the 2.4
kernel OSS module still works? Any help or ideas for me to google on would be
great.

(more debugging details at
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg08889.html)

David

-------
David Parker <david@neongoat.com>
Neon Goat Productions
http://www.neongoat.com
0xF90FFFE5 / F362 51F7 6D51 85EB AF68 75B9 D29B 1AFC F90F FFE5
-------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
