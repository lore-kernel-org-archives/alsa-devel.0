From: Nicholas Taylor <taylor.catharsis@gmail.com>
Subject: Re: Add support for Sigmatel STAC9202/9250/9251 codecs.
Date: Tue, 16 Jan 2007 11:24:46 -0500
Message-ID: <eoiu8f$kac$1@sea.gmane.org>
References: <1167766299.31371.131.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1167766299.31371.131.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi.  I'm a first time user of this newsgroup and a relatively new Linux 
user.  I use the mx6453 model (which I believe leaves me with 9250) and 
have been dealing with no sound in Linux for a few weeks now.  When I 
saw the previous threads concerning test patches for the Sigmatel codecs 
in this newsgroup, I was hoping it might fix the problem.

I tried installing the patch using the instructions you gave on 
http://article.gmane.org/gmane.linux.alsa.devel/42922 for test patch 6. 
  However, once I added the module I was still getting invalid dep range 
errors in the output from dmesg (I'd post it here, but I'm in Windows at 
the moment)  I know you said more work needs to be done on this patch, 
but I thought there might also be the chance I did something wrong. 
Does applying the patch involve a different set of steps than test patch 6?

Also, konsole initially gave me this when I removed the snd_hda_codec 
and put it back in with modprobe

WARNING: Error inserting snd_hda_codec 
(/lib/modules/2.6.15-26-amd64-generic/kernel/sound/pci/hda/snd-hda-codec.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_hda_intel 
(/lib/modules/2.6.15-26-amd64-generic/kernel/sound/pci/hda/snd-hda-intel.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)

A restart made reinserting the module run smoothly, but I can't kick the 
feeling I'm doing something wrong here.  Again, I'm new to this 
newsgroup and Linux in general, so if I'm not supplying enough 
information about the issue, I'm sorry and I'll give you whatever else 
you need.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
