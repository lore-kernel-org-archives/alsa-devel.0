From: "Emilio Federici" <emo_alsa@lycos.com>
Subject: Error compiling alsa-lib-0.9.0rc4
Date: Wed, 23 Oct 2002 14:52:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <GFNEGLNAHNHOKAAA@mailcity.com>
Reply-To: emo_alsa@lycos.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Language: en
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi everybody, I'm setting up a Linux box with a Sb Audigy, so I downloaded the latest Alsa release but I get the following error while compiling the libraries (driver compiling went just fine):

gcc -shared  conf.lo confmisc.lo input.lo output.lo async.lo error.lo dlmisc.lo -Wl,--whole-archive control/.libs/libcontrol.al mixer/.libs/libmixer.al pcm/.libs/libpcm.al rawmidi/.libs/librawmidi.al timer/.libs/libtimer.al hwdep/.libs/libhwdep.al seq/.libs/libseq.al instr/.libs/libinstr.al compat/.libs/libcompat.al -Wl,--no-whole-archive  -lm -ldl -lpthread -lc  -Wl,-soname -Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
/usr/bin/ld: .libs/libasound.so.2.0.0: undefined versioned symbol name snd_pcm_hw_params_get_rate_min@ALSA_0.9.0rc4
/usr/bin/ld: failed to set dynamic section sizes: Bad value
collect2: ld returned 1 exit status
make[2]: *** [libasound.la] Error 1
make[2]: Leaving directory `/usr/src/alsa-lib-0.9.0rc4/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/src/alsa-lib-0.9.0rc4/src'
make: *** [all-recursive] Error 1

Can anybody help me, please?

Emilio Federici


____________________________________________________________
Get 250 full-color business cards FREE right now!
http://businesscards.lycos.com 


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
