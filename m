From: John covici <covici@ccs.covici.com>
Subject: Re: modprobe fails for via82xx in alsa-0.9.3a
Date: Thu, 22 May 2003 08:33:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16076.50081.680574.399031@ccs.covici.com>
References: <m3smr8vasr.fsf@ccs.covici.com>
	<s5hfzn8va58.wl@alsa2.suse.de>
	<16075.25666.840544.292981@ccs.covici.com>
	<s5h7k8kv7xd.wl@alsa2.suse.de>
	<16075.32553.785487.478126@ccs.covici.com>
	<s5h4r3os56r.wl@alsa2.suse.de>
	<m3u1bn5ieg.fsf@ccs.covici.com>
	<s5hptmbqjay.wl@alsa2.suse.de>
Reply-To: covici@ccs.covici.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptmbqjay.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: John Covici <covici@ccs.covici.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Yup, created the directory right from scratch the first time, did
configure, etc. and it seemed to put things in the correct places --
if you want I can send you the config output, and the output of make
and make install.

on Thursday 05/22/2003 Takashi Iwai(tiwai@suse.de) wrote
 > At Thu, 22 May 2003 07:29:27 -0400,
 > John Covici wrote:
 > > 
 > > I am not sure what you mean -- before I run /etc/init.d/alsasound
 > > there are no snd modules at all, so what would modprobe -r
 > > snd-page-alloc do for the situation?
 > 
 > well i was not sure whether it's really not there.
 > 
 > then something wrong in the compilation of the modules.
 > please make sure that you did make clean and the configure refers to
 > the correct linux kernel tree.
 > 
 > 
 > Takashi

-- 
         John Covici
         covici@ccs.covici.com


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
