From: "Ashlesha Shintre" <ashlesha.shintre@gmail.com>
Subject: playback open error:
Date: Wed, 25 Apr 2007 11:15:09 -0400
Message-ID: <975f530d0704250815t294d7cd4g4e5818a2a4c89eaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_83361_2112828.1177514109157"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.230])
	by alsa0.perex.cz (Postfix) with ESMTP id A708B249C0
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2007 17:15:10 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so261725wxd
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2007 08:15:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_83361_2112828.1177514109157
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I m trying to run the simple playback program that I have attached with this
email -- and I get the following error:

ALSA lib pcm_dmix.c:862:(snd_pcm_dmix_open) unable to open slave
> Playback open error: Device or resource busy


I am running this program as a function called wavplay (attached) --
however, if i run the same program, as part of the main function, then there
is no problem --
What i mean is that if i basically just paste the code for the wavplay
function in main and provide the input values (the pcm data to be played) --
then it can very well open the default device and play the pcm data that is
being passed to it!

Any pointers?
Thanks,
Ashlesha.

------=_Part_83361_2112828.1177514109157
Content-Type: text/x-csrc; name="wavplay.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="wavplay.c"
X-Attachment-Id: f_f0xxhnxb

I2luY2x1ZGUgImNvbW1vbi5oIgoKdm9pZCB3YXZwbGF5KHNob3J0IGludCBpbltdLCBpbnQgbGFz
dGluZCkgICAgICAgICAvL2xhc3RpbmQgLSBuby4gb2Ygc2FtcGxlcyBmcm9tIGJ1ZmZpbiB0byBi
ZSBwbGF5ZWQKewogICAgc3RhdGljIGNoYXIgKmRldmljZSA9ICJkZWZhdWx0IjsgICAgICAgICAg
ICAgICAgICAgICAgICAvKiBwbGF5YmFjayBkZXZpY2UgKi8KICAgIHNuZF9vdXRwdXRfdCAqb3V0
cHV0ID0gTlVMTDsKICAgIGludCBjb3VudDsKICAgIHNob3J0IGludCBidWZmaW5bbGFzdGluZF07
CiAgICBpbnQgZXJyLGJ5dGVzcmVhZD0xOwogICAgdW5zaWduZWQgaW50IGk7CiAgICBjaGFyIGQ7
CiAgICBzbmRfcGNtX3QgKmhhbmRsZTsKICAgIHNuZF9wY21fc2ZyYW1lc190IGZyYW1lczsKICAg
CiAgICBjb3VudD0wOwogICAgd2hpbGUoY291bnQ8bGFzdGluZCkgICAgICAgICAgICAgICAgICAg
IC8vIGNvcHkgdGhlIGlucHV0IGJ1ZmZlciBpbnRvIGEgbG9jYWwgYnVmZmVyIHRvIGJlIHBsYXll
ZAogICAgICAgIGJ1ZmZpbltjb3VudF09aW5bY291bnQrK107CiAgICAKCi8vICAgICAgICBwcmlu
dGYoIm5vLiBvZiBzYW1wbGVzIEAxNjAwMEh6IGFyZSAlZFxuIixjb3VudCk7CiAgICAgIAogICAg
ICAgICAgICAgIGlmICgoZXJyID0gc25kX3BjbV9vcGVuKCZoYW5kbGUsIGRldmljZSwgU05EX1BD
TV9TVFJFQU1fUExBWUJBQ0ssIDApKSA8IDApIHsKICAgICAgICAgICAgICAgICAgICAgIHByaW50
ZigiUGxheWJhY2sgb3BlbiBlcnJvcjogJXNcbiIsIHNuZF9zdHJlcnJvcihlcnIpKTsKICAgICAg
ICAgICAgICAgICAgICAgIGV4aXQoRVhJVF9GQUlMVVJFKTsKICAgICAgICAgICAgICB9CiAgICAg
ICAgICAgICAgaWYgKChlcnIgPSBzbmRfcGNtX3NldF9wYXJhbXMoaGFuZGxlLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNORF9QQ01fRk9STUFUX1MxNl9MRSwg
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU05EX1BDTV9BQ0NF
U1NfUldfSU5URVJMRUFWRUQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxNjAw
MCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEwMDAwKSkgPCAwKSB7ICAgLyog
MiBzZWMgKi8KICAgICAgICAgICAgICAgICAgICAgIHByaW50ZigiUGxheWJhY2sgb3BlbiBlcnJv
cjogJXNcbiIsIHNuZF9zdHJlcnJvcihlcnIpKTsKICAgICAgICAgICAgICAgICAgICAgIGV4aXQo
RVhJVF9GQUlMVVJFKTsKICAgICAgICAgICAgICB9CiAgICAgIAogICAgICAgICAgICAgIGZvciAo
aSA9IDA7IGkgPCAxNjsgaSsrKSB7CiAgICAgICAgICAgICAgICAgICAgICAvL2ZyYW1lcyA9IHNu
ZF9wY21fd3JpdGVpKGhhbmRsZSwgYnVmZmluLCBzaXplb2YoYnVmZmluKSk7CiAgICAgICAgICAg
ICAgICAgICAgICBmcmFtZXMgPSBzbmRfcGNtX3dyaXRlaShoYW5kbGUsIGJ1ZmZpbiwgMTI4MDAw
KTsKICAgICAgICAgICAgICAgICAgICAgIGlmIChmcmFtZXMgPCAwKQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBmcmFtZXMgPSBzbmRfcGNtX3JlY292ZXIoaGFuZGxlLCBmcmFtZXMsIDAp
OwogICAgICAgICAgICAgICAgICAgICAgaWYgKGZyYW1lcyA8IDApIHsKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcHJpbnRmKCJzbmRfcGNtX3dyaXRlaSBmYWlsZWQ6ICVzXG4iLCBzbmRf
c3RyZXJyb3IoZXJyKSk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwogICAg
ICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgICAgaWYgKGZyYW1lcyA+IDAg
JiYgZnJhbWVzIDwgKGxvbmcpc2l6ZW9mKGJ1ZmZpbikpCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHByaW50ZigiU2hvcnQgd3JpdGUgKGV4cGVjdGVkICVsaSwgd3JvdGUgJWxpKVxuIiwg
KGxvbmcpc2l6ZW9mKGJ1ZmZpbiksIGZyYW1lcyk7CiAgICAgICAgICAgICAgfQogICAgICAKICAg
ICAgICAgICAgICBzbmRfcGNtX2Nsb3NlKGhhbmRsZSk7CiAgICAgICAgICAgIAogICAgICAgICAg
ICAgIC8vcmV0dXJuIDA7CiAgICAgIH0KCgovLyBwcm9ibGVtIGlzIHRoZSBmYWN0IHRoYXQgdGhl
IGFsc2EgZ2l2ZXMgYW4gZXJyb3Igb24gdGhlIGRldmljZSBvcGVuISBzYXlzIGRldmljZSBpcyBi
dXN5Li4KLy8gL2Rldi9kc3AgYW5kIGZ1c2VyIC12IC9kZXYvZHNwIGdpdmVzIG5vIG91dHB1dCEK

------=_Part_83361_2112828.1177514109157
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_83361_2112828.1177514109157--
