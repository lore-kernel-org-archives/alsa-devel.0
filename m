From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: CMI9780 and ALSA volume control
Date: Tue, 13 Apr 2004 20:38:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xd66bbu57.fsf@kth.se>
References: <92C0412E07F63549B2A2F2345D3DB515F7D42E@cm-msg-02.cmedia.com.tw> <s5h7jwjvm4z.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> At Mon, 12 Apr 2004 11:04:55 +0800,
> C.L. Tien <cltien@cmedia.com.tw> wrote:
>> 
>> 9780 has no PCM volume control, master volume control doesn't
>> control the PCM, either. This feature is the same as other C-Media
>> AC97 Codecs. 
>> 
>> I once posted a patch that tune PCM volume in SW way (change PCM
>> data in DMA buffer), but it was not accepted. 
>
> IMO, doing this s/w volume in the driver is not the optimal
> solution.  i prefer having this feature in alsa-lib. 
>
> the only drawback of implementing in alsa-lib is that the kernel OSS
> emulation cannot support it, and that would surely annoy people.

In a way that's a good thing.  If OSS doesn't work more people will
request ALSA support from applications.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
