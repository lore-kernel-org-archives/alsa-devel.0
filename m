From: Paul Davis <pbd@Op.Net>
Subject: Re: libasound segfault
Date: Wed, 13 Mar 2002 09:04:28 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203131403.JAA29811@renoir.op.net>
References: <3C8B698A.CF0DE577@kolumbus.fi>
In-Reply-To: Your message of "Sun, 10 Mar 2002 16:11:22 +0200."
             <3C8B698A.CF0DE577@kolumbus.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>(gdb) bt
>#0  0x4015e8d7 in snd_pcm_route_convert1_one () from /usr/lib/libasound.so.2
>#1  0x40cae5dc in ?? ()
>#2  0x012de908 in ?? ()
>Error accessing memory address 0xe8c1018b: No such process.
>(gdb)
>
>
>When reading plughw after requesting 24-bit format. I expect the output
>should be 32-bit words with data in upper 24 bits. 16-bit format works and
>asking for 32-bit format gives shared memory errors.

(i was waiting for some insightful comment from jaroslav or abramo :)

no, as I've mentioned several times on LAD, S24_[LB]E is real 24 bit
data, not 24-in-32. 24-in-32 is handled by S32_[BL]E, and the msbits
value is set in the params struct to indicate where the significant
bits are. S32_LE has been used on at least 4 types of ALSA-support
with the "hw" device type. I don't know about with "plughw".

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
