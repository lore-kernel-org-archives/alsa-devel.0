From: John covici <covici@ccs.covici.com>
Subject: Re: modprobe fails for via82xx in alsa-0.9.3a
Date: Wed, 21 May 2003 07:34:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16075.25666.840544.292981@ccs.covici.com>
References: <m3smr8vasr.fsf@ccs.covici.com>
	<s5hfzn8va58.wl@alsa2.suse.de>
Reply-To: covici@ccs.covici.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzn8va58.wl@alsa2.suse.de>
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

Should I delete it from the module tree, or if not, when should I do
an rmmod -- seems that the script would just reload it again as it
loads everything with snd if I remember correctly.

on Wednesday 05/21/2003 Takashi Iwai(tiwai@suse.de) wrote
 > At Wed, 21 May 2003 06:44:36 -0400,
 > John Covici wrote:
 > > 
 > > Hi.  I tried to install alsa-0.9.3a and when it did the modprobe for
 > > the via82xx module, I got unresolved symbols -- all of which had to
 > > do with memory (I don't have them exactly to report now), but they
 > > seemed to come from another module snd-page-alloc .
 > > 
 > > Any assistance would be appreciated.
 > 
 > please try to unload snd-page-alloc module manually if it still
 > persists.  alsasound init script won't unload it to keep the bulk
 > memory areas.
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
