From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [alsa-cvslog] CVS: alsa-lib/test iecbits.c,NONE,1.1 iecset.c,NONE,1.1
 .cvsignore,1.11,1.12 Makefile.am,1.24,1.25
Date: Tue, 30 Sep 2003 18:20:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F79BB58.2080301@superbug.demon.co.uk>
References: <E1A4NtA-0002Dv-00@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1A4NtA-0002Dv-00@sc8-pr-cvs1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Update of /cvsroot/alsa/alsa-lib/test
> In directory sc8-pr-cvs1:/tmp/cvs-serv8451
> 
> Modified Files:
> 	.cvsignore Makefile.am 
> Added Files:
> 	iecbits.c iecset.c 
> Log Message:
> added iecset program (this could be to alsa-utils after more
> enhancements).
> 
This could be useful for a number of reasons.
One reason it might help for is this.
1) Application outputing to the "front" device outputs sound to the 
spdif with PCM iec mode set.
2) Application finishes, leaving PCM iec mode set.
3) New application outputs AC3 stream with NON-AUDIO iec mode set.
4) Application finishes, leaving PCM iec mode set.
5) New application outputs AC3 stream with NON-AUDIO iec mode set.
6) Application gets killed with "kill -9 PID" leaving NON-AUDIO iec mode 
set.
7) Application outputing to the "front" device outputs sound, but the 
spdif is left in NON-AUDIO iec mode, so no sound comes out of the spdif.
 From then onwards all application outputting sound will default to 
NON-AUDIO bit being set, when the sensible assumption would be to set 
PCM mode as default, and only set NON-AUDIO mode when using a device 
name like "iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2"

So my question is, can iecbits.c code be used to set the default iec 
mode back to PCM, if it has accidentally been fixed on NON-AUDIO due to 
the kill -9 ?

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
