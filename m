From: "Ashlesha Shintre" <ashlesha.shintre@gmail.com>
Subject: error in recovery from buffer under-run.
Date: Wed, 2 May 2007 11:26:01 -0400
Message-ID: <975f530d0705020826p7bdaa979hef9003e75cac9fd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6863_24827294.1178119561031"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 299CA2443C
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2007 17:26:02 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so165525wxd
	for <alsa-devel@alsa-project.org>; Wed, 02 May 2007 08:26:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Aditya Shankar <mc.aditya@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_6863_24827294.1178119561031
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Thanks for the link you emailed earlier.  I tried writing my own code, based
on the how to in the alsa wiki.  I have attached that code with this email.


The problem it faces is a buffer underrun every alternate time, i try
writing to the device.

In my code, to take care of underruns, I do the following:

period_size=64;
buffer is a short int array which is 16000 in length.
every alternate call to snd_pcm_writei is successful but only write in the
vicinity of 1350 frames, instead of size which is initialised to length of
buffer.

Now, in the code below, the snd_pcm_recover function prints a message
indicating a buffer under-run has occured, however, it returns a 0,
indicating success in recovery from the error!

I am not sure how to deal with this -- is there a problem with my ALSA
libraries?
Sorry about the length of this email and thanks again,

Ashlesha.

while(size>(2*period_size))
> {
> frames = snd_pcm_writei (pcm_handle, buffer, size);
> printf("frames returned is %d\n",frames);
> if (frames>0)
>     temp=frames;
> if (frames ==  -32){
>           frames = snd_pcm_recover(pcm_handle, frames, 0);
>           printf("recover returned %d\n",frames);
>           }
> if (frames < 0){
>           printf("snd_pcm_writei failed: %s\n", snd_strerror(frames));
>           return -1;
>           }
> printf("%d frames written\n",frames);
> if(temp>0)
>     size=size-temp;
> }
>

------=_Part_6863_24827294.1178119561031
Content-Type: text/x-csrc; name="async_ash.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="async_ash.c"
X-Attachment-Id: f_f17xylk7

LyogTXkgY29kZSB1c2luZyB0aGUgQUxTQSBBc3luY2hyb25vdXMgcGxheWJhY2sgd2lraSAqLwoK
I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDwvdXNyL2luY2x1ZGUvYWxzYS9hc291bmRsaWIu
aD4KI2luY2x1ZGUgPC91c3IvaW5jbHVkZS9hbHNhL3BjbS5oPgojaW5jbHVkZSA8c3lzL3R5cGVz
Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGZjbnRsLmg+CgojZGVmaW5lIFNJWkUg
MTI2OTc2CgovKkdsb2JhbCBWYXJpYWJsZXMgKi8KaW50IGVycjsgCmNvbnN0IGNoYXIgKmRldmlj
ZV9uYW1lID0gImRlZmF1bHQiOyAKCgppbnQgbWFpbigpCnsKCnNuZF9wY21fdCAqcGNtX2hhbmRs
ZTsKCnVuc2lnbmVkIGludCBycmF0ZSA9IDE2MDAwOwppbnQgZmQxLGNvdW50LGJ5dGVzcmVhZD0x
LGEsZXJyLGZyYW1lcyxpLHNpemU9U0laRSx0ZW1wOwpzaG9ydCBpbnQgYnVmZmVyW1NJWkVdOwpj
aGFyIGQ7CmNoYXIgZXJyc3RyWzUwXTsKCnNuZF9wY21fdWZyYW1lc190IGJ1ZmZlcl9zaXplID0g
MTAyNDsKc25kX3BjbV91ZnJhbWVzX3QgcGVyaW9kX3NpemUgPSA2NDsKc25kX3BjbV9od19wYXJh
bXNfdCAqaHdfcGFyYW1zOwpzbmRfcGNtX3N3X3BhcmFtc190ICpzd19wYXJhbXM7CgogaWYoKGZk
MT1vcGVuKCJvcmlnLndhdiIsT19SRE9OTFksMCkpPT0tMSkgewogICAgICAgIHByaW50ZigiZXJy
b3Igb3BlbmluZyBmaWxlXG4iKTsKICAgICAgICByZXR1cm4gLTE7CiAgICB9CiAgICAgICAgIAog
ICAgZm9yKGNvdW50PTA7Y291bnQ8NDQ7Y291bnQrKykKICAgIHsKICAgICAgICBhPXJlYWQoZmQx
LCZkLHNpemVvZihjaGFyKSk7ICAgICAgICAvL2ZpcnN0IDQwIGJ5dGVzIG9mIHRoZSB3YXYgZmls
ZQogICAgfSAgICAKICAgICAgICAgICAgCiAgICAgICAgCiAgIGNvdW50PTA7CiAgIHdoaWxlKGJ5
dGVzcmVhZCA+MCAmJiBjb3VudDxTSVpFKQogICAgICAgICBieXRlc3JlYWQgPSByZWFkKCBmZDEg
LCAmYnVmZmVyW2NvdW50KytdLCBzaXplb2YoIHNob3J0IGludCApICk7CgogICBwcmludGYoIm5v
LiBvZiBzYW1wbGVzIEAxNjAwMEh6IGFyZSAlZFxuIixjb3VudCk7ICAgLy8gY291bnQgaXMgdGhl
IHNpemUgb2YgdGhlIHdhdmUgZmlsZQogICBwcmludGYoImJ5dGVzcmVhZCA9ICVkXG4iLGJ5dGVz
cmVhZCk7ICAgICAgICAKCgoKaWYoKGVyciA9IHNuZF9wY21fb3BlbiAoJnBjbV9oYW5kbGUsIGRl
dmljZV9uYW1lLCBTTkRfUENNX1NUUkVBTV9QTEFZQkFDSywgMCkpIT0wKQogICAgICAgIHsKICAg
ICAgICBwcmludGYoImVyciBpbiBwY20gb3BlblxuIik7CiAgICAgICAgcHJpbnRmKCJlcnJzdHIg
aXMgJXNcbiIsc25kX3N0cmVycm9yIChlcnIpKTsKICAgICAgICByZXR1cm4gLTE7CiAgICAgICAg
fQoKaWYoKGVycj1zbmRfcGNtX2h3X3BhcmFtc19tYWxsb2MgKCZod19wYXJhbXMpKSE9MCl7CiAg
ICAgICAgcHJpbnRmKCJtYWxsb2MgZXJyXG4iKTsKICAgICAgICBwcmludGYoImVycnN0ciBpcyAl
c1xuIixzbmRfc3RyZXJyb3IgKGVycikpOwogICAgICAgIHJldHVybiAtMTsKICAgICAgICB9CgoK
CmlmICgoZXJyID0gc25kX3BjbV9zZXRfcGFyYW1zKCAgICAgICAgICAgICAgcGNtX2hhbmRsZSwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTkRfUENNX0ZPUk1B
VF9TMTZfTEUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU05E
X1BDTV9BQ0NFU1NfUldfSU5URVJMRUFWRUQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAxNjAwMCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAx
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEwMCkpIDwgMCkg
eyAgIAogICAgICAgICAgICAgIHByaW50ZigiUGxheWJhY2sgb3BlbiBlcnJvcjogJXNcbiIsIHNu
ZF9zdHJlcnJvcihlcnIpKTsKICAgICAgICAgICAgICBleGl0KEVYSVRfRkFJTFVSRSk7CiAgICAg
ICAgICAgICAgfQoKCgppZiAoKGVycj1zbmRfcGNtX3ByZXBhcmUgKHBjbV9oYW5kbGUpKTwwKXsK
ICAgIHByaW50ZigicGNtIHByZXBhcmUgZXJyb3IgJWRcbiIsZXJyKTsKICAgIHByaW50ZigiZXJy
c3RyIGlzICVzXG4iLHNuZF9zdHJlcnJvciAoZXJyKSk7CiAgICB9CmZyYW1lcz0wOwoKc2l6ZT1T
SVpFOwp0ZW1wPTA7CndoaWxlKHNpemU+KDIqcGVyaW9kX3NpemUpKQp7CmZyYW1lcyA9IHNuZF9w
Y21fd3JpdGVpIChwY21faGFuZGxlLCBidWZmZXIsIHNpemUpOwpwcmludGYoImZyYW1lcyByZXR1
cm5lZCBpcyAlZFxuIixmcmFtZXMpOwppZiAoZnJhbWVzPjApCiAgICB0ZW1wPWZyYW1lczsKaWYg
KGZyYW1lcyA9PSAgLTMyKXsKICAgICAgICAgIGZyYW1lcyA9IHNuZF9wY21fcmVjb3ZlcihwY21f
aGFuZGxlLCBmcmFtZXMsIDApOwogICAgICAgICAgcHJpbnRmKCJyZWNvdmVyIHJldHVybmVkICVk
XG4iLGZyYW1lcyk7CiAgICAgICAgICB9CmlmIChmcmFtZXMgPCAwKXsKICAgICAgICAgIHByaW50
Zigic25kX3BjbV93cml0ZWkgZmFpbGVkOiAlc1xuIiwgc25kX3N0cmVycm9yKGZyYW1lcykpOwog
ICAgICAgICAgcmV0dXJuIC0xOwogICAgICAgICAgfQpwcmludGYoIiVkIGZyYW1lcyB3cml0dGVu
XG4iLGZyYW1lcyk7CmlmKHRlbXA+MCkKICAgIHNpemU9c2l6ZS10ZW1wOwp9CnNuZF9wY21fY2xv
c2UgKHBjbV9oYW5kbGUpOwpyZXR1cm4gMDsKfQo=
------=_Part_6863_24827294.1178119561031
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_6863_24827294.1178119561031--
