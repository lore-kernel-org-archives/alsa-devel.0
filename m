From: l9jj@163.com
Subject: Re: what is period_size, buffer_size and boundary size,
	i confuse them
Date: Mon, 10 Dec 2012 17:19:13 +0800 (GMT+08:00)
Message-ID: <419cdbb8.56f.13b841c6ac0.Coremail.l9jj@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_Part_6077_1144653966.1355131153077"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m13-239.163.com (m13-239.163.com [220.181.13.239])
 by alsa0.perex.cz (Postfix) with ESMTP id A8474261576
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2012 10:19:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_6077_1144653966.1355131153077
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

dGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBoZWxwLiBpIGdvdCBhbm90aGVyIHF1ZXN0aW9u
IGluIHRoZSBpbnRlcmZhY2Ugc25kX3BjbV91cGRhdGVfaHdfcHRyMCgpLiBUaGUgcmVmZXJlbmNl
IGNvZGUgaXMgYmVsb3cuICgxKWkga25vdyB0aGF0IHRoZSByZXN1bHQgb2YgcmVwcmVzZW50YXRp
b24gKGhkZWx0YSAqIEhaKSAvIHJ1bnRpbWUtPnJhdGUgbWVhbnMgdGhlIGRlbHRhIGppZmZpZXMg
d2hpY2ggc3BlbmQgb24gbW92aW5nIHRoZSBkYXRhIGZyb20gdGhlIG5ld19od19wdHIgdG8gdGhl
IG9sZF9od19wdHIgaW4gdGhlIGRtYSBidWZmZXIuICgyKWFuZCB0aGUgamRlbHRhIHJlcHJlc2Vu
dHMgdGhlIGludGVydmFsIGppZmZpZXMgYmV0d2VlbiBub3cgYW5kIGxhc3QgdGltZSBlbnRlciBo
ZXJlLgoKKDMpdGhlIHF1ZXN0aW9uIGlzIHdoeSBjYW4gd2UgdGhpbmsgdGhlcmUgaXMgbW9yZSB0
aGFuIG9uZSBpbnRlcnJ1cHQgaGFzIGxvc3QgYWNyb3NzIGNvbXBhcmluZyB0aGUgdHdvIHZhcmlh
YmxlcyBzaXplPyAoNClhbmQgaWYgdGhlIGNvbXBhcmUgaWRlYXIgc2V0dXAgdGhhdCBtZWFucyBv
bmUgaW50ZXJydXB0IHdpbGwgdGFrZSBqZGVsdGEgamlmZmllcyBpbiB0aW1lLHNvIGlmIHNvbWVv
bmUgaXMgYmlnZ2VyIGl0IHdlIGNhbiBrbm93IHRoYXQuaXMgaXQgdHJ1ZT8gKDUpaWYgdGhlICg0
KSBpcyBjb3JyZWN0LCB3aHkgZG8gbm90IHVzZSB0aGUgcmVwcmVzZW50YXRpb24gKHJ1bnRpbWUt
PnBlcmlvZF9zaXplICogSFopIC8gcnVudGltZS0+cmF0ZSkgYXMgdGhlIGludGVycnVwdCBpbnRl
cnZhbCwgYmVjYXVzZSBpdCBpcyBmaXhlZCBhbmQgdGhlIGpkZWx0YSBpcyBub3QuICg2KXdoeSBw
bHVzIHRoZSBIWi8xMDAgYWZ0ZXIgamRlbHRhIGFuZCAocnVudGltZS0+cGVyaW9kX3NpemUgKiBI
WikgLyBydW50aW1lLT5yYXRlKSA/IGZvciBlbnN1cmluZyBoYXZlIGVub3VnaHQgdGltZT8gSFog
PT0+IDEgcyBIWi8xMDAwID09PT4gMSBtcyBIWi8xMDAgPT09PiAxMCBtcyA/ID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PXJlZmVyZW5jZSBjb2RlIHN0YXJ0ID09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT4gLyogU2tpcCB0aGUgamlmZmllcyBjaGVjayBmb3IgaGFy
ZHdhcmVzIHdpdGggQkFUQ0ggZmxhZy4gKiBTdWNoIGhhcmR3YXJlIHVzdWFsbHkganVzdCBpbmNy
ZWFzZXMgdGhlIHBvc2l0aW9uIGF0IGVhY2ggSVJRLCAqIHRodXMgaXQgY2FuJ3QgZ2l2ZSBhbnkg
c3RyYW5nZSBwb3NpdGlvbi4gKi9pZiAocnVudGltZS0+aHcuaW5mbyAmIFNORFJWX1BDTV9JTkZP
X0JBVENIKSBnb3RvIG5vX2ppZmZpZXNfY2hlY2s7IGhkZWx0YSA9IGRlbHRhOyBpZiAoaGRlbHRh
IDwgcnVudGltZS0+ZGVsYXkpIGdvdG8gbm9famlmZmllc19jaGVjazsgaGRlbHRhIC09IHJ1bnRp
bWUtPmRlbGF5OyBqZGVsdGEgPSBqaWZmaWVzIC0gcnVudGltZS0+aHdfcHRyX2ppZmZpZXM7IGlm
ICgoKGhkZWx0YSAqIEhaKSAvIHJ1bnRpbWUtPnJhdGUpID4gamRlbHRhICsgSFovMTAwKSB7IGRl
bHRhID0gamRlbHRhIC8oKChydW50aW1lLT5wZXJpb2Rfc2l6ZSAqIEhaKSAvIHJ1bnRpbWUtPnJh
dGUpICsgSFovMTAwKTsgLyogbW92ZSBuZXdfaHdfcHRyIGFjY29yZGluZyBqaWZmaWVzIG5vdCBw
b3MgdmFyaWFibGUgKi9uZXdfaHdfcHRyID0gb2xkX2h3X3B0cjsgaHdfYmFzZSA9IGRlbHRhOyAv
KiB1c2UgbG9vcCB0byBhdm9pZCBjaGVja3MgZm9yIGRlbHRhIG92ZXJmbG93cyAqLy8qIHRoZSBk
ZWx0YSB2YWx1ZSBpcyBzbWFsbCBvciB6ZXJvIGluIG1vc3QgY2FzZXMgKi93aGlsZSAoZGVsdGEg
PiAwKSB7IG5ld19od19wdHIgKz0gcnVudGltZS0+cGVyaW9kX3NpemU7IGlmIChuZXdfaHdfcHRy
ID49IHJ1bnRpbWUtPmJvdW5kYXJ5KSBuZXdfaHdfcHRyIC09IHJ1bnRpbWUtPmJvdW5kYXJ5OyBk
ZWx0YS0tOyB9IC8qIGFsaWduIGh3X2Jhc2UgdG8gYnVmZmVyX3NpemUgKi9od19wdHJfZXJyb3Io
c3Vic3RyZWFtLCAiaHdfcHRyIHNraXBwaW5nISAlcyIgIihwb3M9JWxkLCBkZWx0YT0lbGQsIHBl
cmlvZD0lbGQsICIgImpkZWx0YT0lbHUvJWx1LyVsdSwgaHdfcHRyPSVsZC8lbGQpXG4iLCBpbl9p
bnRlcnJ1cHQgPyAiW1FdICIgOiAiIiwgKGxvbmcpcG9zLCAobG9uZyloZGVsdGEsIChsb25nKXJ1
bnRpbWUtPnBlcmlvZF9zaXplLCBqZGVsdGEsICgoaGRlbHRhICogSFopIC8gcnVudGltZS0+cmF0
ZSksIGh3X2Jhc2UsICh1bnNpZ25lZCBsb25nKW9sZF9od19wdHIsICh1bnNpZ25lZCBsb25nKW5l
d19od19wdHIpOyAvKiByZXNldCB2YWx1ZXMgdG8gcHJvcGVyIHN0YXRlICovZGVsdGEgPSAwOyBo
d19iYXNlID0gbmV3X2h3X3B0ciAtIChuZXdfaHdfcHRyICUgcnVudGltZS0+YnVmZmVyX3NpemUp
OyB9IDw9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PWVuZCA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0gQmVzdCBSZWdhcmRzLgoK
CgoK5ZyoIDIwMTItMTItMTAgMTY6MjQ6NTksIENsZW1lbnMgTGFkaXNjaCA8Y2xlbWVuc0BsYWRp
c2NoLmRlPuWGmemBkzoKbDlqakAxNjMuY29tIHdyb3RlOgo+IGRvZXMgIHRoZSB2YXJpYWJsZSBi
dWZmZXJfc2l6ZSBlcXVhbCB0byAgRE1BIHNpemU/CgpZZXMuCgo+ICgyKWhvdyB0aGUgcG9zPmJ1
ZmZlcl9zaXplIHdpbGwgaGFwcGVuIGluIHRoZSBpbnRlcmZhY2Ugc25kX3BjbV91cGRhdGVfaHdf
cHRyMCgpPwoKSXQgaGFwcGVucyB3aGVuIHlvdXIgZHJpdmVyIGhhcyBhIGJ1Zy4gIFRoZSAucG9p
bnRlciBjYWxsYmFjayBhbHdheXMgbXVzdApyZXR1cm4gdmFsdWUgdGhhdCBpcyBpbnNpZGUgdGhl
IERNQSBidWZmZXIuCgoKUmVnYXJkcywKQ2xlbWVucwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwKCgpsOWpqQDE2My5jb20KCiDigJTigJTnvZHmmJPpgq7nrrHm
iYvmnLrlrqLmiLfnq6/igJTigJQ=
------=_Part_6077_1144653966.1355131153077
Content-Type: application/octet-stream; name=emailtxt.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=emailtxt.txt

thank you very much for your help.
i got another question in the interface snd_pcm_update_hw_ptr0().
The reference code is below.
(1)i know that the result of representation (hdelta * HZ) / runtime->rate means the delta jiffies which spend on moving the data from the new_hw_ptr to the old_hw_ptr in the dma buffer.
(2)and the jdelta represents the interval jiffies between now and last time enter here.


(3)the question is why can we think there is more than one interrupt has lost across comparing the two variables size?
(4)and if the compare idear setup that means one interrupt will take jdelta jiffies in time,so if someone is bigger it we can know that.is it true?
(5)if the (4) is correct, why do not use the representation (runtime->period_size * HZ) / runtime->rate) as the interrupt interval, because it is fixed and the jdelta is not.
(6)why plus the HZ/100 after  jdelta and (runtime->period_size * HZ) / runtime->rate) ? for ensuring have enought time?
   HZ ==> 1 s
   HZ/1000 ===> 1  ms
   HZ/100  ===> 10 ms   ?
=================================reference code  start ====================================>
	/* Skip the jiffies check for hardwares with BATCH flag.
	 * Such hardware usually just increases the position at each IRQ,
	 * thus it can't give any strange position.
	 */
	if (runtime->hw.info & SNDRV_PCM_INFO_BATCH)
		goto no_jiffies_check;
	hdelta = delta;
	if (hdelta < runtime->delay)
		goto no_jiffies_check;
	hdelta -= runtime->delay;
	jdelta = jiffies - runtime->hw_ptr_jiffies;
	if (((hdelta * HZ) / runtime->rate) > jdelta + HZ/100) {    
		delta = jdelta /
			(((runtime->period_size * HZ) / runtime->rate)
								+ HZ/100);
		/* move new_hw_ptr according jiffies not pos variable */
		new_hw_ptr = old_hw_ptr;
		hw_base = delta;
		/* use loop to avoid checks for delta overflows */
		/* the delta value is small or zero in most cases */
		while (delta > 0) {
			new_hw_ptr += runtime->period_size;
			if (new_hw_ptr >= runtime->boundary)
				new_hw_ptr -= runtime->boundary;
			delta--;
		}
		/* align hw_base to buffer_size */
		hw_ptr_error(substream,
			     "hw_ptr skipping! %s"
			     "(pos=%ld, delta=%ld, period=%ld, "
			     "jdelta=%lu/%lu/%lu, hw_ptr=%ld/%ld)\n",
			     in_interrupt ? "[Q] " : "",
			     (long)pos, (long)hdelta,
			     (long)runtime->period_size, jdelta,
			     ((hdelta * HZ) / runtime->rate), hw_base,
			     (unsigned long)old_hw_ptr,
			     (unsigned long)new_hw_ptr);
		/* reset values to proper state */
		delta = 0;
		hw_base = new_hw_ptr - (new_hw_ptr % runtime->buffer_size);
	}
<======================================end ===================================================
Best Regards.


------=_Part_6077_1144653966.1355131153077
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_6077_1144653966.1355131153077--
