From: ian <deviant@custard.org>
Subject: dlmisc.c problem
Date: Thu, 31 Oct 2002 22:14:50 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210312156140.27359-100000@rhubarb.custard.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,
I am currently working on porting the midi i/o of JSynthLib to use the
ALSA sequencer api rather than OSS. JSynthLib is a synthesiser librarian
written in java. I am using JNI (java native interface) as the glue
between c and java. The way this works is that a java tools creates a
header file containing the functions you required to be implemented
nativley, you then implement these functions, and finally compile them
into a shared library that your java code loads. This is all working fine,
except when i go to make calls to the sequencer api. ALSA gives me the
following errors:
ALSA lib dlmisc.c:100:(snd_dlsym_verify) unable to verify version for
symbol snd_config_hook_load
ALSA lib conf.c:2655:(snd_config_hooks_call) symbol snd_config_hook_load
is not defined inside (null)
ALSA lib conf.c:3066:(snd_config_update_r) hooks failed, removing
configuration
Open error: No such device or address
I noticed that dlmisc.c has a printf on line 98 that is gives a bit of
info, so uncommented it and got the following info:
dlsym verify: -2, vname = '_snd_config_hook_load_dlsym_config_hook_001'
Well, using nm to look at libasound.so reports that symbol as present. So
I'm a bit confused. I'm using alsa-lib-0.9rc3 on redhat 7.3 with gcc 2.96.
Any ideas?
Thanks, Ian




-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
