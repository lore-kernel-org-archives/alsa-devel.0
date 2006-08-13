From: "Richard Fish" <bigfish@asmallpond.org>
Subject: [PATCH]: improvements to hda-intel sigmatel codec S3
	resume
Date: Sun, 13 Aug 2006 02:01:53 -0700
Message-ID: <7573e9640608130201y734832f1ob3db66bae2f2c581@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_53170_31158249.1155459713856"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_53170_31158249.1155459713856
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I noticed a problem with S3 resume and my STAC9200 Intel HDA chip.  If
I restart alsa after resuming, the pin configurations are wrong.  My
specific system isn't recognized, so it ends up using the BIOS
configuration, but the BIOS doesn't fix up the config registers on
resume.  The debug messages with --with-debug=detect after boot are:

.../patch_sigmatel.c:1279: hda_codec: Unknown model for STAC9200,
using BIOS defaults
.../hda_codec.c:2150: autoconfig: line_outs=0 (0x0/0x0/0x0/0x0/0x0)
.../hda_codec.c:2154:    speaker_outs=2 (0xe/0x11/0x0/0x0/0x0)
.../hda_codec.c:2156:    hp=0xd, dig_out=0x9, din_in=0x0
.../hda_codec.c:2164:    inputs: mic=0x10, fmic=0x0, line=0x0,
fline=0x0, cd=0x0, aux=0x0

While reloading after an S3 resume produces:

.../patch_sigmatel.c:1279: hda_codec: Unknown model for STAC9200,
using BIOS defaults
.../hda_codec.c:2150: autoconfig: line_outs=1 (0xe/0x0/0x0/0x0/0x0)
.../hda_codec.c:2154:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
.../hda_codec.c:2156:    hp=0xd, dig_out=0x9, din_in=0x8
.../hda_codec.c:2164:    inputs: mic=0x0, fmic=0x10, line=0xf,
fline=0x0, cd=0x12, aux=0x0

Note that I am not talking about unloading the drivers before suspend,
and reloading them afterwards...there is really nothing that can be
done for that case obviously.  I'm just looking to be able to do an
"alsasound restart" or driver update without having to reboot.

So, my proposed and attached patch stores off the BIOS configuration,
and restores it on resume.  Please review and comment.  One thing it
does that may not be correct is that it uses the STAC_REF slot in the
tables to store the BIOS configuration.  If this is a problem, it
should be easy enough to just add a STAC_BIOS slot to the tables.

Please CC me on any replies.

Regards,
-Richard

------=_Part_53170_31158249.1155459713856
Content-Type: application/octet-stream; name="rjf-alsa-20060813.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rjf-alsa-20060813.patch"
X-Attachment-Id: f_eqt6v2un

LS0tIGFsc2Eta2VybmVsL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYy5vcmlnCTIwMDYtMDgtMTMg
MDA6MDE6MDAuMTU4MTAyMTQ2IC0wNzAwCisrKyBhbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNoX3Np
Z21hdGVsLmMJMjAwNi0wOC0xMyAwMTozOTozMi4yMDg0NTQxMDggLTA3MDAKQEAgLTQ2OSw2ICs0
NjksMjUgQEAKIAl7fSAvKiB0ZXJtaW5hdG9yICovCiB9OwogCitzdGF0aWMgdm9pZCBzdGFjOTJ4
eF9zYXZlX2Jpb3NfY29uZmlnX3JlZ3Moc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCit7CisJaW50
IGk7CisJc3RydWN0IHNpZ21hdGVsX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKKwkJCisJZm9y
IChpID0gMDsgaSA8IHNwZWMtPm51bV9waW5zOyBpKyspIHsKKwkJaGRhX25pZF90IG5pZCA9IHNw
ZWMtPnBpbl9uaWRzW2ldOworCQl1bnNpZ25lZCBpbnQgcGluX2NmZzsKKwkJCisJCXBpbl9jZmcg
PSBzbmRfaGRhX2NvZGVjX3JlYWQoY29kZWMsIG5pZCwgMCwgCisJCQlBQ19WRVJCX0dFVF9DT05G
SUdfREVGQVVMVCwgMHgwMCk7CQorCQlzbmRfcHJpbnRkZChLRVJOX0lORk8gImhkYV9jb2RlYzog
cGluIG5pZCAlMi4yeCBiaW9zIHBpbiBjb25maWcgJTguOHhcbiIsCisJCQkJCW5pZCwgcGluX2Nm
Zyk7CisJCXNwZWMtPnBpbl9jb25maWdzW2ldID0gcGluX2NmZzsKKwl9CisJCisJcmV0dXJuOwor
fQorCiBzdGF0aWMgdm9pZCBzdGFjOTJ4eF9zZXRfY29uZmlnX3JlZ3Moc3RydWN0IGhkYV9jb2Rl
YyAqY29kZWMpCiB7CiAJaW50IGk7CkBAIC0xMjQyLDYgKzEyNjEsNyBAQAogCWludCBpOwogCiAJ
c3RhYzkyeHhfaW5pdChjb2RlYyk7CisJc3RhYzkyeHhfc2V0X2NvbmZpZ19yZWdzKGNvZGVjKTsK
IAlmb3IgKGkgPSAwOyBpIDwgc3BlYy0+bnVtX21peGVyczsgaSsrKQogCQlzbmRfaGRhX3Jlc3Vt
ZV9jdGxzKGNvZGVjLCBzcGVjLT5taXhlcnNbaV0pOwogCWlmIChzcGVjLT5tdWx0aW91dC5kaWdf
b3V0X25pZCkKQEAgLTEyNzQsMTIgKzEyOTQsMTUgQEAKIAkJcmV0dXJuIC1FTk9NRU07CiAKIAlj
b2RlYy0+c3BlYyA9IHNwZWM7CisJc3BlYy0+bnVtX3BpbnMgPSA4OworCXNwZWMtPnBpbl9uaWRz
ID0gc3RhYzkyMDBfcGluX25pZHM7CiAJc3BlYy0+Ym9hcmRfY29uZmlnID0gc25kX2hkYV9jaGVj
a19ib2FyZF9jb25maWcoY29kZWMsIHN0YWM5MjAwX2NmZ190YmwpOwotCWlmIChzcGVjLT5ib2Fy
ZF9jb25maWcgPCAwKQotICAgICAgICAgICAgICAgIHNuZF9wcmludGRkKEtFUk5fSU5GTyAiaGRh
X2NvZGVjOiBVbmtub3duIG1vZGVsIGZvciBTVEFDOTIwMCwgdXNpbmcgQklPUyBkZWZhdWx0c1xu
Iik7CisJaWYgKHNwZWMtPmJvYXJkX2NvbmZpZyA8IDApIHsKKwkJc25kX3ByaW50ZGQoS0VSTl9J
TkZPICJoZGFfY29kZWM6IFVua25vd24gbW9kZWwgZm9yIFNUQUM5MjAwLCB1c2luZyBCSU9TIGRl
ZmF1bHRzXG4iKTsKKwkJc3BlYy0+cGluX2NvbmZpZ3MgPSBzdGFjOTIwMF9icmRfdGJsW1NUQUNf
UkVGXTsKKwkJc3RhYzkyeHhfc2F2ZV9iaW9zX2NvbmZpZ19yZWdzKGNvZGVjKTsKKwl9CiAJZWxz
ZSB7Ci0JCXNwZWMtPm51bV9waW5zID0gODsKLQkJc3BlYy0+cGluX25pZHMgPSBzdGFjOTIwMF9w
aW5fbmlkczsKIAkJc3BlYy0+cGluX2NvbmZpZ3MgPSBzdGFjOTIwMF9icmRfdGJsW3NwZWMtPmJv
YXJkX2NvbmZpZ107CiAJCXN0YWM5Mnh4X3NldF9jb25maWdfcmVncyhjb2RlYyk7CiAJfQpAQCAt
MTMxNSwxMyArMTMzOCwxNiBAQAogCQlyZXR1cm4gLUVOT01FTTsKIAogCWNvZGVjLT5zcGVjID0g
c3BlYzsKKwlzcGVjLT5udW1fcGlucyA9IDEwOworCXNwZWMtPnBpbl9uaWRzID0gc3RhYzkyMnhf
cGluX25pZHM7CiAJc3BlYy0+Ym9hcmRfY29uZmlnID0gc25kX2hkYV9jaGVja19ib2FyZF9jb25m
aWcoY29kZWMsIHN0YWM5MjJ4X2NmZ190YmwpOwotCWlmIChzcGVjLT5ib2FyZF9jb25maWcgPCAw
KQotICAgICAgICAgICAgICAgIHNuZF9wcmludGRkKEtFUk5fSU5GTyAiaGRhX2NvZGVjOiBVbmtu
b3duIG1vZGVsIGZvciBTVEFDOTIyeCwgIgotCQkJICAgICJ1c2luZyBCSU9TIGRlZmF1bHRzXG4i
KTsKKwlpZiAoc3BlYy0+Ym9hcmRfY29uZmlnIDwgMCkgeworCQlzbmRfcHJpbnRkZChLRVJOX0lO
Rk8gImhkYV9jb2RlYzogVW5rbm93biBtb2RlbCBmb3IgU1RBQzkyMngsICIKKwkJCSJ1c2luZyBC
SU9TIGRlZmF1bHRzXG4iKTsKKwkJc3BlYy0+cGluX2NvbmZpZ3MgPSBzdGFjOTIyeF9icmRfdGJs
W1NUQUNfUkVGXTsKKwkJc3RhYzkyeHhfc2F2ZV9iaW9zX2NvbmZpZ19yZWdzKGNvZGVjKTsKKwl9
CiAJZWxzZSBpZiAoc3RhYzkyMnhfYnJkX3RibFtzcGVjLT5ib2FyZF9jb25maWddICE9IE5VTEwp
IHsKLQkJc3BlYy0+bnVtX3BpbnMgPSAxMDsKLQkJc3BlYy0+cGluX25pZHMgPSBzdGFjOTIyeF9w
aW5fbmlkczsKIAkJc3BlYy0+cGluX2NvbmZpZ3MgPSBzdGFjOTIyeF9icmRfdGJsW3NwZWMtPmJv
YXJkX2NvbmZpZ107CiAJCXN0YWM5Mnh4X3NldF9jb25maWdfcmVncyhjb2RlYyk7CiAJfQpAQCAt
MTM3OCwxMiArMTQwNCwxNSBAQAogCQlyZXR1cm4gLUVOT01FTTsKIAogCWNvZGVjLT5zcGVjID0g
c3BlYzsKKwlzcGVjLT5udW1fcGlucyA9IDE0OworCXNwZWMtPnBpbl9uaWRzID0gc3RhYzkyN3hf
cGluX25pZHM7CiAJc3BlYy0+Ym9hcmRfY29uZmlnID0gc25kX2hkYV9jaGVja19ib2FyZF9jb25m
aWcoY29kZWMsIHN0YWM5Mjd4X2NmZ190YmwpOwotCWlmIChzcGVjLT5ib2FyZF9jb25maWcgPCAw
KQotICAgICAgICAgICAgICAgIHNuZF9wcmludGRkKEtFUk5fSU5GTyAiaGRhX2NvZGVjOiBVbmtu
b3duIG1vZGVsIGZvciBTVEFDOTI3eCwgdXNpbmcgQklPUyBkZWZhdWx0c1xuIik7CisJaWYgKHNw
ZWMtPmJvYXJkX2NvbmZpZyA8IDApIHsKKwkJc25kX3ByaW50ZGQoS0VSTl9JTkZPICJoZGFfY29k
ZWM6IFVua25vd24gbW9kZWwgZm9yIFNUQUM5Mjd4LCB1c2luZyBCSU9TIGRlZmF1bHRzXG4iKTsK
KwkJc3BlYy0+cGluX2NvbmZpZ3MgPSBzdGFjOTI3eF9icmRfdGJsW1NUQUNfUkVGXTsKKwkJc3Rh
YzkyeHhfc2F2ZV9iaW9zX2NvbmZpZ19yZWdzKGNvZGVjKTsKKwl9CiAJZWxzZSB7Ci0JCXNwZWMt
Pm51bV9waW5zID0gMTQ7Ci0JCXNwZWMtPnBpbl9uaWRzID0gc3RhYzkyN3hfcGluX25pZHM7CiAJ
CXNwZWMtPnBpbl9jb25maWdzID0gc3RhYzkyN3hfYnJkX3RibFtzcGVjLT5ib2FyZF9jb25maWdd
OwogCQlzdGFjOTJ4eF9zZXRfY29uZmlnX3JlZ3MoY29kZWMpOwogCX0KQEAgLTE0MTgsMTIgKzE0
NDcsMTUgQEAKIAkJcmV0dXJuIC1FTk9NRU07CiAKIAljb2RlYy0+c3BlYyA9IHNwZWM7CisJc3Bl
Yy0+bnVtX3BpbnMgPSAxNDsKKwlzcGVjLT5waW5fbmlkcyA9IHN0YWM5MjA1X3Bpbl9uaWRzOwog
CXNwZWMtPmJvYXJkX2NvbmZpZyA9IHNuZF9oZGFfY2hlY2tfYm9hcmRfY29uZmlnKGNvZGVjLCBz
dGFjOTIwNV9jZmdfdGJsKTsKLQlpZiAoc3BlYy0+Ym9hcmRfY29uZmlnIDwgMCkKLSAgICAgICAg
ICAgICAgICBzbmRfcHJpbnRkZChLRVJOX0lORk8gImhkYV9jb2RlYzogVW5rbm93biBtb2RlbCBm
b3IgU1RBQzkyMDUsIHVzaW5nIEJJT1MgZGVmYXVsdHNcbiIpOworCWlmIChzcGVjLT5ib2FyZF9j
b25maWcgPCAwKSB7CisJCXNuZF9wcmludGRkKEtFUk5fSU5GTyAiaGRhX2NvZGVjOiBVbmtub3du
IG1vZGVsIGZvciBTVEFDOTIwNSwgdXNpbmcgQklPUyBkZWZhdWx0c1xuIik7CisJCXNwZWMtPnBp
bl9jb25maWdzID0gc3RhYzkyMDVfYnJkX3RibFtTVEFDX1JFRl07CisJCXN0YWM5Mnh4X3NhdmVf
Ymlvc19jb25maWdfcmVncyhjb2RlYyk7CisJfQogCWVsc2UgewotCQlzcGVjLT5udW1fcGlucyA9
IDE0OwotCQlzcGVjLT5waW5fbmlkcyA9IHN0YWM5MjA1X3Bpbl9uaWRzOwogCQlzcGVjLT5waW5f
Y29uZmlncyA9IHN0YWM5MjA1X2JyZF90Ymxbc3BlYy0+Ym9hcmRfY29uZmlnXTsKIAkJc3RhYzky
eHhfc2V0X2NvbmZpZ19yZWdzKGNvZGVjKTsKIAl9Cg==
------=_Part_53170_31158249.1155459713856
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_Part_53170_31158249.1155459713856
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_Part_53170_31158249.1155459713856--
