From: Alex Romosan <romosan@sycorax.lbl.gov>
Subject: Re: Trident problems.
Date: Sat, 30 Aug 2003 10:47:37 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <873cfj82bq.fsf@sycorax.lbl.gov>
References: <20030828005741.162b0565.david@neongoat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030828005741.162b0565.david@neongoat.com> (message from
 David Parker on Thu, 28 Aug 2003 00:57:41 -0700)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Parker <david@neongoat.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Parker <david@neongoat.com> writes:

> A long time ago (many months... sorry I don't know exactly when), my
> Trident card stopped working with ALSA on a Debian unstable box. It
> still works with the kernel OSS module, but ALSA has problems with
> the AC'97 codec. Here's what I tried and the resulting log
> messages/output:
>
> hypnotic:/home/dap# modprobe snd-trident
> ALSA ../../alsa-kernel/pci/trident/trident_main.c:3394: AC'97 codec ready error
> Trident 4DWave PCI soundcard not found or device busy
> devfs_register(unknown): could not append to parent, err: -17
> ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:2096: AC'97 0:0 does not respond - RESET
> Trident 4DWave PCI soundcard not found or device busy
>

i have exactly the same problem. the weird thing is when it happened
(many months ago) i tried to go back to the previous working version
and it still didn't work. my theory is that the ac'97 codec got into a
funky state and it's not being reset. unfortunately i don't know what
to do either.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
