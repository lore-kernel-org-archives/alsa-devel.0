From: Stefan Gartner <stefang@aon.at>
Subject: Re: unresolved symbols
Date: Fri, 28 Jun 2002 20:02:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17O04A-0008U3-00@usw-sf-list1.sourceforge.net>
References: <3D1C9CCB.57D4B3AF@abc.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D1C9CCB.57D4B3AF@abc.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Bo Forslund <bo.forslund@abc.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 28 June 2002 19:28, Bo Forslund wrote:
[...]
>
> and inserting the module gives lots of lines like this.
>
> insmod  snd-emu10k1.o
> snd-emu10k1.o: unresolved symbol snd_ctl_remove_Rsmp_5daf11ea
> snd-emu10k1.o: unresolved symbol snd_verbose_printk_Rsmp_49d4e4d1
> snd-emu10k1.o: unresolved symbol
> snd_pcm_hw_constraint_minmax_Rsmp_74cec7bb
>

does the same thing happen if you run "modprobe snd-emu10k1"?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
