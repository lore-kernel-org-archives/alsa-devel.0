From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Question regarding period/buffer and error handling
Date: Fri, 28 May 2004 10:22:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xiseh0xlt.fsf@kth.se>
References: <40B6970F.90507@atr.jp> <yw1x1xl5rq3g.fsf@kth.se>
 <40B6F1A0.4080704@atr.jp>
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
List-Id: alsa-devel@alsa-project.org

Cournapeau David <cournape@atr.jp> writes:

> Måns Rullgård wrote:
>
>>
>>If you are playing fairly short pieces of sound you might be able to
>>use this function I wrote some time ago:
>>
>>function playsnd(y,fs,bits)
>>
>>wf = tempname;
>>ws = warning;
>>warning off
>>wavwrite(y, fs, bits, wf);
>>warning ws
>>wf = [wf '.wav'];
>>[s,o] = unix(sprintf('aplay %s', wf));
>>delete(wf);
>>
> Well, I precisely want to avoid writing to a temporary file :)

If the files are small they will probably never hit the physical
disk.  Of course, your sounds might be longer than that.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
