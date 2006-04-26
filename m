From: Dave Maley <dmaley@nc.rr.com>
Subject: Re: [patch] problem w/ arecord "split interleaved
	files" feature
Date: Wed, 26 Apr 2006 17:56:18 -0400
Message-ID: <1146088578.9316.44.camel@flanders>
References: <1145943804.2670.43.camel@flanders>
	 <s5hmze9zpnn.wl%tiwai@suse.de> <1145999255.7045.27.camel@flanders>
	 <s5hirow5svs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hirow5svs.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I found a stupid bug there.  arecord doesn't quit properly at
> max_filesize due to a wrong comparison.  The fix patch is below.

Excellent - Thanks much.  I'll test this tonight and report back the
results.

> Maybe 2GB is OK.  I'll fix it too.

No idea what the spec says but I've recorded test wave files which were
exactly 2GB and they didn't seem to have any problems (played fine in
totem and opened properly in a wave editor).

Thanks again for you prompt responses and patch!

~Dave



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
