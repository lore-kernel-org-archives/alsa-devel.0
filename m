From: Pete Zaitcev <zaitcev@yahoo.com>
Subject: snd_pcm_writei is stuck with EPIPE
Date: Fri, 12 Nov 2004 22:24:47 -0800 (PST)
Message-ID: <20041113062447.51636.qmail@web60404.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1200859685-1100327087=:51627"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
Cc: mh@mpg123.de, syrjala@sci.fi, ahermans@vf.telia.no, zaitcev@yahoo.com
List-Id: alsa-devel@alsa-project.org

--0-1200859685-1100327087=:51627
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hello, All:

I have updated mpg123 to ALSA 0.9.0 API. The support for ALSA in currently
available mpg123-0.59r does not build on Fedora Core 3.

Everything seems to work, except that a single underflow is enough to
kill everything. When an underflow happens, instead of a mere skip,
snd_pcm_writei starts to return EPIPE and that's it. The device has to
be closed and reopened before it can work again. Does anyone have an
idea what may be going on?

I am attaching a patch and audio_alsa.c file itself in case anyone
is curious.

Thanks,
-- Pete



		
__________________________________ 
Do you Yahoo!? 
Check out the new Yahoo! Front Page. 
www.yahoo.com 
 

--0-1200859685-1100327087=:51627
Content-Type: application/octet-stream; name="audio_alsa.c"
Content-Transfer-Encoding: base64
Content-Description: audio_alsa.c
Content-Disposition: attachment; filename="audio_alsa.c"

LyoKICogIERyaXZlciBmb3IgQWR2YW5jZWQgTGludXggU291bmQgQXJjaGl0
ZWN0dXJlLCBodHRwOi8vYWxzYS5qY3UuY3oKICogCiAqICBDb2RlIGJ5IEFu
ZGVycyBTZW1iIEhlcm1hbnNlbiA8YWhlcm1hbnNAdmYudGVsaWEubm8+CiAq
ICBDbGVhbnVwcyBieSBKYXJvc2xhdiBLeXNlbGEgPHBlcmV4QGpjdS5jej4K
ICogICAgICAgICAgICAgIFZpbGxlIFN5cmphbGEgPHN5cmphbGFAc2NpLmZp
PgogKiAgQUxTQSAwLjkuMCBBUEkgYnkgUGV0ZSBaYWl0Y2V2IDx6YWl0Y2V2
QHlhaG9vLmNvbT4KICoKICogIFlvdSBjYW4gdXNlIC1hIDxzb3VuZGNhcmQg
bmFtZT46PGRldmljZSAjPlssPHN1YmRldmljZSAjPl0uLi4KICogIEZvciBl
eGFtcGxlOiBtcGcxMjMgLWEgaHc6MCwwIGFhYS5tcGcKICogICAgICAgICAg
ICAgICBtcGcxMjMgLWEgZ3VzcG5wOjEgYWFhLm1wZwogKgogKiBUaGlzIGZp
bGUgY29tZXMgdW5kZXIgR1BMIGxpY2Vuc2UuIAogKi8KCiNpbmNsdWRlICJt
cGcxMjMuaCIKCiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPGN0eXBl
Lmg+CiNpbmNsdWRlIDxhbHNhL2Fzb3VuZGxpYi5oPgoKc3RhdGljIGludCBh
dWRpb19zZXRfcGxheWJhY2tfcGFyYW1zKHN0cnVjdCBhdWRpb19pbmZvX3N0
cnVjdCAqYWkpOwoKaW50IGF1ZGlvX29wZW4oc3RydWN0IGF1ZGlvX2luZm9f
c3RydWN0ICphaSkKewoJaW50IGVycjsKCWNoYXIgKmRldmljZTsKCglpZigh
YWkpCgkJcmV0dXJuIC0xOwoJaWYoYWktPmRldmljZSkgewkvKiBwYXJzZSBB
TFNBIGRldmljZSBuYW1lICovCgkJZGV2aWNlID0gYWktPmRldmljZTsKCX0g
ZWxzZSB7CgkJZGV2aWNlID0gImh3OjAsMCI7Cgl9CgoJaWYgKChlcnIgPSBz
bmRfcGNtX29wZW4oJmFpLT5oYW5kbGUsIGRldmljZSwgU05EX1BDTV9TVFJF
QU1fUExBWUJBQ0ssIDApKSA8IDApCgl7CgkJZnByaW50ZihzdGRlcnIsICJv
cGVuIGZhaWxlZCBmb3IgJXM6ICVzXG4iLCBkZXZpY2UsIHNuZF9zdHJlcnJv
cihlcnIpKTsKCQkvKgoJCSAqIEFuIGV4aXQgaXMgcHJldHR5IGRpc2d1c3Rp
bmcsIGZvciBhIGxpYnJhcnkuCgkJICogV2UgYXJlIHRyeWluZyB0byBwcmV2
ZW50IHBlcnJvcigpIGluIG1wZzEyMyBmcm9tCgkJICogdXNpbmcgYSBib2d1
cyBlcnJuby4KCQkgKi8KCQlleGl0KDEpOwoJfQoKCWlmICgoZXJyID0gc25k
X3BjbV9od19wYXJhbXNfbWFsbG9jKCZhaS0+cGFyYW1zKSkgPCAwKSB7CgkJ
ZnByaW50ZihzdGRlcnIsICJwYXJhbXMgbWFsbG9jIGZhaWxlZDogJXNcbiIs
IHNuZF9zdHJlcnJvcihlcnIpKTsKCQlzbmRfcGNtX2Nsb3NlKGFpLT5oYW5k
bGUpOwoJCXJldHVybiAtMTsKCX0KCglhdWRpb19zZXRfcGxheWJhY2tfcGFy
YW1zKGFpKTsJLyogUHJvYmFibHkgbm90IHJlYWxseSBuZWVkZWQuICovCgly
ZXR1cm4gMDsKfQoKLyoKICogQUxTQSdzIHNldHRpbmcgbW9kZWwgaXMgYSBw
aGFudGFzbWFnb3JpYyBuaWdodG1hcmUuIEl0IGhhcyBubyBub3Rpb24gb2Yg
YQogKiBjdXJyZW50IHNldHRpbmcsIGJ1dCBvbmx5IGEgbm90aW9uIG9mIGEg
Y3VycmVudCBzZXQgb2Ygc2V0dGluZ3MuIFRoZSBvbmx5IHdheQogKiB0byBz
ZXQgcmF0ZSBhbmQgZm9ybWF0IGlzIHRvIHN0YXJ0IHdpdGggYSBzZXQgd2hp
Y2ggaW5jbHVkZXMgYWxsIHNldHRpbmdzLAogKiB0aGVuIG5hcnJvdyBpdCBk
b3duIHRvIHRoZSBzZXR0aW5ncyB5b3UgbmVlZC4KICovCnN0YXRpYyBpbnQg
YXVkaW9fc2V0X3BsYXliYWNrX3BhcmFtcyhzdHJ1Y3QgYXVkaW9faW5mb19z
dHJ1Y3QgKmFpKQp7CglzbmRfcGNtX2h3X3BhcmFtc190ICpwcCA9IGFpLT5w
YXJhbXM7CglpbnQgZXJyOwojaWYgMAoJaW50IGRpcjsKCXNuZF9wY21fdWZy
YW1lc190IGJ1ZmZlcl9zaXplOwoJc25kX3BjbV91ZnJhbWVzX3QgcGVyaW9k
X3NpemUsIG1pbl9wZXJpb2Rfc2l6ZSwgbWF4X3BlcmlvZF9zaXplOwojZW5k
aWYKCXNuZF9wY21fZm9ybWF0X3QgZm9ybWF0OwoKCS8qCgkgKiBGaXJzdCwg
b2J0YWluIHRoZSBjb21wbGV0ZSBzZXQuCgkgKi8KCWlmICgoZXJyID0gc25k
X3BjbV9od19wYXJhbXNfYW55KGFpLT5oYW5kbGUsIHBwKSkgPCAwKSB7CgkJ
ZnByaW50ZihzdGRlcnIsICJzbmRfcGNtX2h3X3BhcmFtc19hbnkgZmFpbGVk
OiAlc1xuIiwKCQkgICAgc25kX3N0cmVycm9yKGVycikpOwoJCXJldHVybiAt
MTsKCX0KCgkvKgoJICogTmFycm9yb3cgYWNjZXNzIChub3Qgc2V0dGFibGUp
CgkgKi8KCWVyciA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9hY2Nlc3MoYWkt
PmhhbmRsZSwgcHAsIFNORF9QQ01fQUNDRVNTX1JXX0lOVEVSTEVBVkVEKTsK
CWlmIChlcnIgPCAwKSB7CgkJZnByaW50ZihzdGRlcnIsICJzbmRfcGNtX2h3
X3BhcmFtc19zZXRfYWNjZXNzIGZhaWxlZDogJXNcbiIsCgkJICAgIHNuZF9z
dHJlcnJvcihlcnIpKTsKCQlyZXR1cm4gLTE7Cgl9CgoJLyoKCSAqIE5hcnJv
dyB0aGUgc2V0IHdpdGggbXBnMTIzIHNldHRhYmxlczogY2hhbm5lbHMsIGZv
cm1hdCwgcmF0ZS4KCSAqLwoJaWYgKGFpLT5jaGFubmVscyA+PSAxKSB7CgkJ
ZXJyID0gc25kX3BjbV9od19wYXJhbXNfc2V0X2NoYW5uZWxzKGFpLT5oYW5k
bGUsIHBwLCBhaS0+Y2hhbm5lbHMpOwoJCWlmIChlcnIgPCAwKSB7CgkJCWZw
cmludGYoc3RkZXJyLAoJCQkgICAgInNuZF9wY21faHdfcGFyYW1zX3NldF9j
aGFubmVscyBmYWlsZWQ6ICVzXG4iLAoJCQkgICAgc25kX3N0cmVycm9yKGVy
cikpOwoJCQlyZXR1cm4gLTE7CgkJfQoJfQoKCXN3aXRjaChhaS0+Zm9ybWF0
KQoJewoJY2FzZSBBVURJT19GT1JNQVRfU0lHTkVEXzE2OgoJZGVmYXVsdDoK
CQlmb3JtYXQgPSBTTkRfUENNX0ZPUk1BVF9TMTY7CgkJYnJlYWs7CgljYXNl
IEFVRElPX0ZPUk1BVF9VTlNJR05FRF84OgoJCWZvcm1hdCA9IFNORF9QQ01f
Rk9STUFUX1U4OwoJCWJyZWFrOwoJY2FzZSBBVURJT19GT1JNQVRfU0lHTkVE
Xzg6CgkJZm9ybWF0ID0gU05EX1BDTV9GT1JNQVRfUzg7CgkJYnJlYWs7Cglj
YXNlIEFVRElPX0ZPUk1BVF9VTEFXXzg6CgkJZm9ybWF0ID0gU05EX1BDTV9G
T1JNQVRfTVVfTEFXOwoJCWJyZWFrOwoJY2FzZSBBVURJT19GT1JNQVRfQUxB
V184OgoJCWZvcm1hdCA9IFNORF9QQ01fRk9STUFUX0FfTEFXOwoJCWJyZWFr
OwoJY2FzZSBBVURJT19GT1JNQVRfVU5TSUdORURfMTY6CgkJZm9ybWF0ID0g
U05EX1BDTV9GT1JNQVRfVTE2OwoJCWJyZWFrOwoJfQoJZXJyID0gc25kX3Bj
bV9od19wYXJhbXNfc2V0X2Zvcm1hdChhaS0+aGFuZGxlLCBwcCwgZm9ybWF0
KTsKCWlmIChlcnIgPCAwKSB7CgkJZnByaW50ZihzdGRlcnIsCgkJICAgICJz
bmRfcGNtX2h3X3BhcmFtc19zZXRfZm9ybWF0IGZhaWxlZDogJXNcbiIsCgkJ
ICAgIHNuZF9zdHJlcnJvcihlcnIpKTsKCQlyZXR1cm4gLTE7Cgl9CgoJaWYg
KGFpLT5yYXRlID49IDApIHsKCQllcnIgPSBzbmRfcGNtX2h3X3BhcmFtc19z
ZXRfcmF0ZShhaS0+aGFuZGxlLCBwcCwgYWktPnJhdGUsIDApOwoJCWlmIChl
cnIgPCAwKSB7CgkJCWZwcmludGYoc3RkZXJyLAoJCQkgICAgInNuZF9wY21f
aHdfcGFyYW1zX3NldF9yYXRlIGZhaWxlZDogJXNcbiIsCgkJCSAgICBzbmRf
c3RyZXJyb3IoZXJyKSk7CgkJCXJldHVybiAtMTsKCQl9Cgl9CgoJLyoKCSAq
IFJlY2FsY3VsYXRlIHRoZSBsYXRlbmN5IHNldHRpbmdzLiBUaGlzIGlzIG5v
dCBzb21ldGhpbmcgeW91IHdhbnQKCSAqIG9mdGVuLiBUaGUgbXBnMTIzIG5l
ZWRzIHRoaXMgd2hlbiB5b3UgZG8gIG5ldGNhdHxtcGcxMjMgIHRvIGxpc3Rl
bgoJICogdG8gdGhlIHJhZGlvLgoJICovCiNpZiAwIC8qIEtlZXAgdGhpcyBv
ZmYgdGVtcG9yYXJpbHkgd2hpbGUgd2UgZGVidWcgY3V0b2ZmcyBvbiB1bmRl
cmZsb3cgKi8KCWlmICgoZXJyID0gc25kX3BjbV9od19wYXJhbXNfZ2V0X3Bl
cmlvZF9zaXplKHBwLCAmcGVyaW9kX3NpemUsICZkaXIpKSAhPSAwKSB7CgkJ
ZnByaW50ZihzdGRlcnIsICJzbmRfcGNtX2h3X3BhcmFtc19nZXRfcGVyaW9k
X3NpemUgZXJyb3IgJWRcbiIsIGVycik7Cgl9CglwcmludGYoIm9sZCBwZXJp
b2Qgc2l6ZSAlZCAoZGlyICVkKVxuIiwgKGludCkgcGVyaW9kX3NpemUsIGRp
cik7IC8qIFAzICovCgoJc25kX3BjbV9od19wYXJhbXNfZ2V0X3BlcmlvZF9z
aXplX21pbihwcCwgJm1pbl9wZXJpb2Rfc2l6ZSwgJmRpcik7CglzbmRfcGNt
X2h3X3BhcmFtc19nZXRfcGVyaW9kX3NpemVfbWF4KHBwLCAmbWF4X3Blcmlv
ZF9zaXplLCAmZGlyKTsKCWlmIChzbmRfcGNtX2h3X3BhcmFtc19nZXRfYnVm
ZmVyX3NpemUocHAsICZidWZmZXJfc2l6ZSkgIT0gMCkgewoJCWZwcmludGYo
c3RkZXJyLCAic25kX3BjbV9od19wYXJhbXNfZ2V0X2J1ZmZlcl9zaXplIGVy
cm9yXG4iKTsKCX0KCglwZXJpb2Rfc2l6ZSA9IGJ1ZmZlcl9zaXplLzQ7Cglp
ZiAocGVyaW9kX3NpemUgPiBtYXhfcGVyaW9kX3NpemUpIHBlcmlvZF9zaXpl
ID0gbWF4X3BlcmlvZF9zaXplOwoJaWYgKHBlcmlvZF9zaXplIDwgbWluX3Bl
cmlvZF9zaXplKSBwZXJpb2Rfc2l6ZSA9IG1pbl9wZXJpb2Rfc2l6ZTsKCXBy
aW50ZigibmV3IHBlcmlvZCBzaXplICVkXG4iLCAoaW50KSBwZXJpb2Rfc2l6
ZSk7IC8qIFAzICovCglpZiAoKGVyciA9IHNuZF9wY21faHdfcGFyYW1zX3Nl
dF9wZXJpb2Rfc2l6ZShhaS0+aGFuZGxlLCBwcCwgcGVyaW9kX3NpemUsIDAp
KSAhPSAwKSB7CgkJZnByaW50ZihzdGRlcnIsICJwbGF5YmFjayBwYXJhbXMg
ZmFpbGVkOiAlc1xuIiwgc25kX3N0cmVycm9yKGVycikpOwoJfQoKCS8vIFAz
CgkvLyBwcC5mcmFnbWVudHNfbWF4ID0gLTE7CgkvLyBwcC5mcmFnbWVudHNf
cm9vbSA9IDE7CiNlbmRpZgoKCS8qCgkgKiBGaW5hbGx5LCBjb21taXQgc2V0
dGluZ3MgdG8gdGhlIGhhcmR3YXJlLgoJICovCglpZiAoKGVyciA9IHNuZF9w
Y21faHdfcGFyYW1zKGFpLT5oYW5kbGUsIHBwKSkgPCAwKSB7CgkJZnByaW50
ZihzdGRlcnIsICJzbmRfcGNtX2h3X3BhcmFtcyBmYWlsZWQ6ICVzXG4iLCBz
bmRfc3RyZXJyb3IoZXJyKSk7CgkJLyogTm90IGZhdGFsIGZvciBwYXJ0aWFs
IHNldHRpbmdzIGF0IGluaXRpYWxpemF0aW9uICovCgkJcmV0dXJuIDA7Cgl9
CgoJcmV0dXJuIDA7Cn0KCmludCBhdWRpb19yZXNldF9wYXJhbWV0ZXJzKHN0
cnVjdCBhdWRpb19pbmZvX3N0cnVjdCAqYWkpCnsKCglhdWRpb19zZXRfcGxh
eWJhY2tfcGFyYW1zKGFpKTsKCXJldHVybiAwOwp9CgppbnQgYXVkaW9fcmF0
ZV9iZXN0X21hdGNoKHN0cnVjdCBhdWRpb19pbmZvX3N0cnVjdCAqYWkpCnsK
CXJldHVybiAwOwp9CgppbnQgYXVkaW9fc2V0X3JhdGUoc3RydWN0IGF1ZGlv
X2luZm9fc3RydWN0ICphaSkKewoKCWlmKCFhaSB8fCBhaS0+cmF0ZSA8IDAp
CgkJcmV0dXJuIC0xOwoJcmV0dXJuIGF1ZGlvX3NldF9wbGF5YmFja19wYXJh
bXMoYWkpOwp9CgppbnQgYXVkaW9fc2V0X2NoYW5uZWxzKHN0cnVjdCBhdWRp
b19pbmZvX3N0cnVjdCAqYWkpCnsKCglpZihhaS0+Y2hhbm5lbHMgPCAwKQoJ
CXJldHVybiAwOwoJcmV0dXJuIGF1ZGlvX3NldF9wbGF5YmFja19wYXJhbXMo
YWkpOwp9CgppbnQgYXVkaW9fc2V0X2Zvcm1hdChzdHJ1Y3QgYXVkaW9faW5m
b19zdHJ1Y3QgKmFpKQp7CgoJaWYoYWktPmZvcm1hdCA9PSAtMSkKCQlyZXR1
cm4gMDsKCXJldHVybiBhdWRpb19zZXRfcGxheWJhY2tfcGFyYW1zKGFpKTsK
fQoKaW50IGF1ZGlvX2dldF9mb3JtYXRzKHN0cnVjdCBhdWRpb19pbmZvX3N0
cnVjdCAqYWkpCnsKCXNuZF9wY21fZm9ybWF0X21hc2tfdCAqbWFzazsKCWlu
dCBpOwoJaW50IGZtdCA9IC0xOwoKCXN0YXRpYyBpbnQgZm10c1tdID0gewoJ
CUFVRElPX0ZPUk1BVF9TSUdORURfMTYsIEFVRElPX0ZPUk1BVF9VTlNJR05F
RF8xNiwKCQlBVURJT19GT1JNQVRfVU5TSUdORURfOCwgQVVESU9fRk9STUFU
X1NJR05FRF84LAoJCUFVRElPX0ZPUk1BVF9VTEFXXzgsIEFVRElPX0ZPUk1B
VF9BTEFXXzgKCX07CglzdGF0aWMgaW50IGFmbXRzW10gPSB7CgkJU05EX1BD
TV9GT1JNQVRfUzE2LCBTTkRfUENNX0ZPUk1BVF9VMTYsCgkJU05EX1BDTV9G
T1JNQVRfVTgsIFNORF9QQ01fRk9STUFUX1M4LAoJCVNORF9QQ01fRk9STUFU
X01VX0xBVywgU05EX1BDTV9GT1JNQVRfQV9MQVcKCX07CgoJc25kX3BjbV9m
b3JtYXRfbWFza19hbGxvY2EoJm1hc2spOwoKCXNuZF9wY21faHdfcGFyYW1z
X2FueShhaS0+aGFuZGxlLCBhaS0+cGFyYW1zKTsKCXNuZF9wY21faHdfcGFy
YW1zX2dldF9mb3JtYXRfbWFzayhhaS0+cGFyYW1zLCBtYXNrKTsKCWZvciAo
aSA9IDA7IGkgPCA2OyBpKyspIHsKCQlpZiAoc25kX3BjbV9mb3JtYXRfbWFz
a190ZXN0KG1hc2ssIGFmbXRzW2ldKSkgewoJCQlpZiAoZm10ID09IC0xKQoJ
CQkJZm10ID0gMDsKCQkJZm10IHw9IGZtdHNbaV07CgkJfQoJfQoKCXJldHVy
biBmbXQ7Cn0KCmludCBhdWRpb19wbGF5X3NhbXBsZXMoc3RydWN0IGF1ZGlv
X2luZm9fc3RydWN0ICphaSx1bnNpZ25lZCBjaGFyICpidWYsaW50IGxlbikK
ewoJc3NpemVfdCByZXQ7Cgl1bnNpZ25lZCBpbnQgZmFjdG9yOwoKCWZhY3Rv
ciA9IDA7CglpZiAoYWktPmNoYW5uZWxzICE9IDEpIGZhY3RvciArPSAxOwoJ
aWYgKGFpLT5mb3JtYXQgJiBBVURJT19GT1JNQVRfTUFTSykgZmFjdG9yICs9
IDE7CglyZXQgPSBzbmRfcGNtX3dyaXRlaShhaS0+aGFuZGxlLCBidWYsIGxl
biA+PiBmYWN0b3IpOwoJaWYgKHJldCA8IDApIHsKCQlmcHJpbnRmKHN0ZGVy
ciwgInNuZF9wY21fd3JpdGUgZmFpbGVkOiAlc1xuIiwgc25kX3N0cmVycm9y
KHJldCkpOwoJfQoJcmV0dXJuIHJldDsKfQoKaW50IGF1ZGlvX2Nsb3NlKHN0
cnVjdCBhdWRpb19pbmZvX3N0cnVjdCAqYWkpCnsKCWludCByZXQ7CgoJcmV0
ID0gc25kX3BjbV9jbG9zZShhaS0+aGFuZGxlKTsKCXNuZF9wY21faHdfcGFy
YW1zX2ZyZWUoYWktPnBhcmFtcyk7CglyZXR1cm4gcmV0Owp9Cg==

--0-1200859685-1100327087=:51627
Content-Type: text/x-patch; name="mpg123-0.59r-p3.diff"
Content-Description: mpg123-0.59r-p3.diff
Content-Disposition: inline; filename="mpg123-0.59r-p3.diff"

diff -upr mpg123-0.59r/audio_alsa.c mpg123-0.59r-p3/audio_alsa.c
--- mpg123-0.59r/audio_alsa.c	1999-05-28 03:25:50.000000000 -0700
+++ mpg123-0.59r-p3/audio_alsa.c	2004-11-12 22:00:26.704988507 -0800
@@ -4,9 +4,10 @@
  *  Code by Anders Semb Hermansen <ahermans@vf.telia.no>
  *  Cleanups by Jaroslav Kysela <perex@jcu.cz>
  *              Ville Syrjala <syrjala@sci.fi>
+ *  ALSA 0.9.0 API by Pete Zaitcev <zaitcev@yahoo.com>
  *
- *  You can use -a <soundcard #>:<device #>...
- *  For example: mpg123 -a 1:0 aaa.mpg
+ *  You can use -a <soundcard name>:<device #>[,<subdevice #>]...
+ *  For example: mpg123 -a hw:0,0 aaa.mpg
  *               mpg123 -a guspnp:1 aaa.mpg
  *
  * This file comes under GPL license. 
@@ -16,97 +17,179 @@
 
 #include <stdlib.h>
 #include <ctype.h>
-#include <sys/asoundlib.h>
+#include <alsa/asoundlib.h>
 
-#ifdef SND_LITTLE_ENDIAN
-#define SND_PCM_SFMT_S16_NE SND_PCM_SFMT_S16_LE
-#define SND_PCM_SFMT_U16_NE SND_PCM_SFMT_U16_LE
-#define SND_PCM_FMT_S16_NE SND_PCM_FMT_S16_LE
-#define SND_PCM_FMT_U16_NE SND_PCM_FMT_U16_LE
-#else
-#define SND_PCM_SFMT_S16_NE SND_PCM_SFMT_S16_BE
-#define SND_PCM_SFMT_U16_NE SND_PCM_SFMT_U16_BE
-#define SND_PCM_FMT_S16_NE SND_PCM_FMT_S16_BE
-#define SND_PCM_FMT_U16_NE SND_PCM_FMT_U16_BE
-#endif
+static int audio_set_playback_params(struct audio_info_struct *ai);
 
 int audio_open(struct audio_info_struct *ai)
 {
 	int err;
-	int card=0,device=0;
-	char scard[128], sdevice[128];
+	char *device;
 
 	if(!ai)
 		return -1;
 	if(ai->device) {	/* parse ALSA device name */
-		if(strchr(ai->device,':')) {	/* card with device */
-			strncpy(scard, ai->device, sizeof(scard)-1);
-			scard[sizeof(scard)-1] = '\0';
-			if (strchr(scard,':')) *strchr(scard,':') = '\0';
-			card = snd_card_name(scard);
-			if (card < 0) {
-				fprintf(stderr, "wrong soundcard number: %s\n", scard);
-				exit(1);
-			}
-			strncpy(sdevice, strchr(ai->device, ':') + 1, sizeof(sdevice)-1);
-		} else {
-			strncpy(sdevice, ai->device, sizeof(sdevice)-1);
-		}
-		sdevice[sizeof(sdevice)-1] = '\0';
-		device = atoi(sdevice);
-		if (!isdigit(sdevice[0]) || device < 0 || device > 31) {
-			fprintf(stderr, "wrong device number: %s\n", sdevice);
-			exit(1);
-		}
+		device = ai->device;
+	} else {
+		device = "hw:0,0";
 	}
 
-	if((err=snd_pcm_open(&ai->handle, card, device, SND_PCM_OPEN_PLAYBACK)) < 0 )
+	if ((err = snd_pcm_open(&ai->handle, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0)
 	{
-		fprintf(stderr, "open failed: %s\n", snd_strerror(err));
+		fprintf(stderr, "open failed for %s: %s\n", device, snd_strerror(err));
+		/*
+		 * An exit is pretty disgusting, for a library.
+		 * We are trying to prevent perror() in mpg123 from
+		 * using a bogus errno.
+		 */
 		exit(1);
 	}
 
-	if(audio_reset_parameters(ai) < 0)
-	{
-		audio_close(ai);
+	if ((err = snd_pcm_hw_params_malloc(&ai->params)) < 0) {
+		fprintf(stderr, "params malloc failed: %s\n", snd_strerror(err));
+		snd_pcm_close(ai->handle);
 		return -1;
 	}
 
+	audio_set_playback_params(ai);	/* Probably not really needed. */
 	return 0;
 }
 
-static void audio_set_playback_params(struct audio_info_struct *ai)
+/*
+ * ALSA's setting model is a phantasmagoric nightmare. It has no notion of a
+ * current setting, but only a notion of a current set of settings. The only way
+ * to set rate and format is to start with a set which includes all settings,
+ * then narrow it down to the settings you need.
+ */
+static int audio_set_playback_params(struct audio_info_struct *ai)
 {
+	snd_pcm_hw_params_t *pp = ai->params;
 	int err;
-	snd_pcm_playback_info_t pi;
-	snd_pcm_playback_params_t pp;
+#if 0
+	int dir;
+	snd_pcm_uframes_t buffer_size;
+	snd_pcm_uframes_t period_size, min_period_size, max_period_size;
+#endif
+	snd_pcm_format_t format;
 
-	if((err=snd_pcm_playback_info(ai->handle, &pi)) < 0 )
-	{
-		fprintf(stderr, "playback info failed: %s\n", snd_strerror(err));
-		return;	/* not fatal error */
+	/*
+	 * First, obtain the complete set.
+	 */
+	if ((err = snd_pcm_hw_params_any(ai->handle, pp)) < 0) {
+		fprintf(stderr, "snd_pcm_hw_params_any failed: %s\n",
+		    snd_strerror(err));
+		return -1;
 	}
 
-	bzero(&pp, sizeof(pp));
-	pp.fragment_size = pi.buffer_size/4;
-	if (pp.fragment_size > pi.max_fragment_size) pp.fragment_size = pi.max_fragment_size;
-	if (pp.fragment_size < pi.min_fragment_size) pp.fragment_size = pi.min_fragment_size;
-	pp.fragments_max = -1;
-	pp.fragments_room = 1;
+	/*
+	 * Narrorow access (not settable)
+	 */
+	err = snd_pcm_hw_params_set_access(ai->handle, pp, SND_PCM_ACCESS_RW_INTERLEAVED);
+	if (err < 0) {
+		fprintf(stderr, "snd_pcm_hw_params_set_access failed: %s\n",
+		    snd_strerror(err));
+		return -1;
+	}
+
+	/*
+	 * Narrow the set with mpg123 settables: channels, format, rate.
+	 */
+	if (ai->channels >= 1) {
+		err = snd_pcm_hw_params_set_channels(ai->handle, pp, ai->channels);
+		if (err < 0) {
+			fprintf(stderr,
+			    "snd_pcm_hw_params_set_channels failed: %s\n",
+			    snd_strerror(err));
+			return -1;
+		}
+	}
 
-	if((err=snd_pcm_playback_params(ai->handle, &pp)) < 0 )
+	switch(ai->format)
 	{
+	case AUDIO_FORMAT_SIGNED_16:
+	default:
+		format = SND_PCM_FORMAT_S16;
+		break;
+	case AUDIO_FORMAT_UNSIGNED_8:
+		format = SND_PCM_FORMAT_U8;
+		break;
+	case AUDIO_FORMAT_SIGNED_8:
+		format = SND_PCM_FORMAT_S8;
+		break;
+	case AUDIO_FORMAT_ULAW_8:
+		format = SND_PCM_FORMAT_MU_LAW;
+		break;
+	case AUDIO_FORMAT_ALAW_8:
+		format = SND_PCM_FORMAT_A_LAW;
+		break;
+	case AUDIO_FORMAT_UNSIGNED_16:
+		format = SND_PCM_FORMAT_U16;
+		break;
+	}
+	err = snd_pcm_hw_params_set_format(ai->handle, pp, format);
+	if (err < 0) {
+		fprintf(stderr,
+		    "snd_pcm_hw_params_set_format failed: %s\n",
+		    snd_strerror(err));
+		return -1;
+	}
+
+	if (ai->rate >= 0) {
+		err = snd_pcm_hw_params_set_rate(ai->handle, pp, ai->rate, 0);
+		if (err < 0) {
+			fprintf(stderr,
+			    "snd_pcm_hw_params_set_rate failed: %s\n",
+			    snd_strerror(err));
+			return -1;
+		}
+	}
+
+	/*
+	 * Recalculate the latency settings. This is not something you want
+	 * often. The mpg123 needs this when you do  netcat|mpg123  to listen
+	 * to the radio.
+	 */
+#if 0 /* Keep this off temporarily while we debug cutoffs on underflow */
+	if ((err = snd_pcm_hw_params_get_period_size(pp, &period_size, &dir)) != 0) {
+		fprintf(stderr, "snd_pcm_hw_params_get_period_size error %d\n", err);
+	}
+	printf("old period size %d (dir %d)\n", (int) period_size, dir); /* P3 */
+
+	snd_pcm_hw_params_get_period_size_min(pp, &min_period_size, &dir);
+	snd_pcm_hw_params_get_period_size_max(pp, &max_period_size, &dir);
+	if (snd_pcm_hw_params_get_buffer_size(pp, &buffer_size) != 0) {
+		fprintf(stderr, "snd_pcm_hw_params_get_buffer_size error\n");
+	}
+
+	period_size = buffer_size/4;
+	if (period_size > max_period_size) period_size = max_period_size;
+	if (period_size < min_period_size) period_size = min_period_size;
+	printf("new period size %d\n", (int) period_size); /* P3 */
+	if ((err = snd_pcm_hw_params_set_period_size(ai->handle, pp, period_size, 0)) != 0) {
 		fprintf(stderr, "playback params failed: %s\n", snd_strerror(err));
-		return; /* not fatal error */
 	}
+
+	// P3
+	// pp.fragments_max = -1;
+	// pp.fragments_room = 1;
+#endif
+
+	/*
+	 * Finally, commit settings to the hardware.
+	 */
+	if ((err = snd_pcm_hw_params(ai->handle, pp)) < 0) {
+		fprintf(stderr, "snd_pcm_hw_params failed: %s\n", snd_strerror(err));
+		/* Not fatal for partial settings at initialization */
+		return 0;
+	}
+
+	return 0;
 }
 
 int audio_reset_parameters(struct audio_info_struct *ai)
 {
-	audio_set_format(ai);
-	audio_set_channels(ai);
-	audio_set_rate(ai);
 
+	audio_set_playback_params(ai);
 	return 0;
 }
 
@@ -117,81 +200,33 @@ int audio_rate_best_match(struct audio_i
 
 int audio_set_rate(struct audio_info_struct *ai)
 {
-	int ret;
 
 	if(!ai || ai->rate < 0)
 		return -1;
-
-	ai->alsa_format.rate=ai->rate;
-
-	if((ret=snd_pcm_playback_format(ai->handle, &ai->alsa_format)) < 0 )
-		return -1;
-
-	audio_set_playback_params(ai);
-
-	return 0;
+	return audio_set_playback_params(ai);
 }
 
 int audio_set_channels(struct audio_info_struct *ai)
 {
-	int ret;
 
-	if(ai->alsa_format.channels < 0)
+	if(ai->channels < 0)
 		return 0;
-
-	ai->alsa_format.channels = ai->channels;
-
-	if((ret=snd_pcm_playback_format(ai->handle, &ai->alsa_format)) < 0 )
-		return -1;
-
-	audio_set_playback_params(ai);
-
-	return 0;
+	return audio_set_playback_params(ai);
 }
 
 int audio_set_format(struct audio_info_struct *ai)
 {
-	int ret;
 
 	if(ai->format == -1)
 		return 0;
-
-	switch(ai->format)
-	{
-		case AUDIO_FORMAT_SIGNED_16:
-		default:
-			ai->alsa_format.format=SND_PCM_SFMT_S16_NE;
-			break;
-		case AUDIO_FORMAT_UNSIGNED_8:
-			ai->alsa_format.format=SND_PCM_SFMT_U8;
-			break;
-		case AUDIO_FORMAT_SIGNED_8:
-			ai->alsa_format.format=SND_PCM_SFMT_S8;
-			break;
-		case AUDIO_FORMAT_ULAW_8:
-			ai->alsa_format.format=SND_PCM_SFMT_MU_LAW;
-			break;
-		case AUDIO_FORMAT_ALAW_8:
-			ai->alsa_format.format=SND_PCM_SFMT_A_LAW;
-			break;
-		case AUDIO_FORMAT_UNSIGNED_16:
-			ai->alsa_format.format=SND_PCM_SFMT_U16_NE;
-			break;
-	}
-
-	if((ret=snd_pcm_playback_format(ai->handle, &ai->alsa_format)) < 0 )
-		return -1;
-
-	audio_set_playback_params(ai);
-
-	return 0;
+	return audio_set_playback_params(ai);
 }
 
 int audio_get_formats(struct audio_info_struct *ai)
 {
-	int i, err;
+	snd_pcm_format_mask_t *mask;
+	int i;
 	int fmt = -1;
-	snd_pcm_playback_info_t pi;
 
 	static int fmts[] = {
 		AUDIO_FORMAT_SIGNED_16, AUDIO_FORMAT_UNSIGNED_16,
@@ -199,19 +234,17 @@ int audio_get_formats(struct audio_info_
 		AUDIO_FORMAT_ULAW_8, AUDIO_FORMAT_ALAW_8
 	};
 	static int afmts[] = {
-		SND_PCM_FMT_S16_NE, SND_PCM_FMT_U16_NE,
-		SND_PCM_FMT_U8, SND_PCM_FMT_S8,
-		SND_PCM_FMT_MU_LAW, SND_PCM_FMT_A_LAW
+		SND_PCM_FORMAT_S16, SND_PCM_FORMAT_U16,
+		SND_PCM_FORMAT_U8, SND_PCM_FORMAT_S8,
+		SND_PCM_FORMAT_MU_LAW, SND_PCM_FORMAT_A_LAW
 	};
 
-	if((err=snd_pcm_playback_info(ai->handle, &pi)) < 0 )
-	{
-		fprintf(stderr, "playback info failed: %s\n", snd_strerror(err));
-		return -1;
-	}
+	snd_pcm_format_mask_alloca(&mask);
 
+	snd_pcm_hw_params_any(ai->handle, ai->params);
+	snd_pcm_hw_params_get_format_mask(ai->params, mask);
 	for (i = 0; i < 6; i++) {
-		if (pi.formats & afmts[i]) {
+		if (snd_pcm_format_mask_test(mask, afmts[i])) {
 			if (fmt == -1)
 				fmt = 0;
 			fmt |= fmts[i];
@@ -224,15 +257,23 @@ int audio_get_formats(struct audio_info_
 int audio_play_samples(struct audio_info_struct *ai,unsigned char *buf,int len)
 {
 	ssize_t ret;
+	unsigned int factor;
 
-	ret=snd_pcm_write(ai->handle, buf, len);
-
+	factor = 0;
+	if (ai->channels != 1) factor += 1;
+	if (ai->format & AUDIO_FORMAT_MASK) factor += 1;
+	ret = snd_pcm_writei(ai->handle, buf, len >> factor);
+	if (ret < 0) {
+		fprintf(stderr, "snd_pcm_write failed: %s\n", snd_strerror(ret));
+	}
 	return ret;
 }
 
 int audio_close(struct audio_info_struct *ai)
 {
 	int ret;
+
 	ret = snd_pcm_close(ai->handle);
+	snd_pcm_hw_params_free(ai->params);
 	return ret;
 }
Only in mpg123-0.59r-p3: audio_alsa.o
diff -upr mpg123-0.59r/audio.c mpg123-0.59r-p3/audio.c
--- mpg123-0.59r/audio.c	1999-04-06 08:53:05.000000000 -0700
+++ mpg123-0.59r-p3/audio.c	2004-11-10 23:04:58.000000000 -0800
@@ -17,9 +17,7 @@ void audio_info_struct_init(struct audio
   ai->output = -1;
 #ifdef ALSA
   ai->handle = NULL;
-  ai->alsa_format.format = -1;
-  ai->alsa_format.rate = -1;
-  ai->alsa_format.channels = -1;
+  ai->params = NULL;
 #endif
   ai->device = NULL;
   ai->channels = -1;
diff -upr mpg123-0.59r/audio.h mpg123-0.59r-p3/audio.h
--- mpg123-0.59r/audio.h	1999-06-15 13:22:03.000000000 -0700
+++ mpg123-0.59r-p3/audio.h	2004-11-10 22:15:16.000000000 -0800
@@ -35,9 +35,8 @@ enum { DECODE_TEST, DECODE_AUDIO, DECODE
 #include <dmedia/audio.h>
 #endif
 
-
 #ifdef ALSA
-#include <sys/asoundlib.h>
+#include <alsa/asoundlib.h>
 #endif
 
 struct audio_info_struct
@@ -53,8 +52,8 @@ struct audio_info_struct
   long gain;
   int output;
 #ifdef ALSA
-  void *handle;
-  snd_pcm_format_t alsa_format;
+  snd_pcm_t *handle;
+  snd_pcm_hw_params_t *params;
 #endif
   char *device;
   int channels;

--0-1200859685-1100327087=:51627--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
