From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: unresolved symbols
Date: Sat, 29 Jun 2002 19:03:55 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1D860B.9030300@boosthardware.com>
References: <3D1C9CCB.57D4B3AF@abc.se> <E17O04A-0008U3-00@usw-sf-list1.sourceforge.net>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Stefan Gartner <stefang@aon.at>
Cc: Bo Forslund <bo.forslund@abc.se>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Stefan Gartner wrote:
> On Friday 28 June 2002 19:28, Bo Forslund wrote:
> [...]
> 
>>and inserting the module gives lots of lines like this.
>>
>>insmod  snd-emu10k1.o
>>snd-emu10k1.o: unresolved symbol snd_ctl_remove_Rsmp_5daf11ea
>>snd-emu10k1.o: unresolved symbol snd_verbose_printk_Rsmp_49d4e4d1
>>snd-emu10k1.o: unresolved symbol
>>snd_pcm_hw_constraint_minmax_Rsmp_74cec7bb
>>
> 
> 
> does the same thing happen if you run "modprobe snd-emu10k1"?
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Caffeinated soap. No kidding.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 

I have put some info about this problem in the alsa wiki

http://alsa.opensrc.org






-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
