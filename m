From: Tomas Pospisek's Mailing Lists <tpo2@sourcepole.ch>
Subject: [patch] Re:  No state is present for card CMI8738
Date: Tue, 22 May 2007 23:02:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705222114350.5158@localhost>
References: <Pine.LNX.4.64.0705160024160.13010@localhost>
	<Pine.LNX.4.64.0705181634160.22953@localhost>
	<s5hfy5qp3gr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-704422492-1179867749=:5158"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viefep23-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B915244B7
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2007 23:02:39 +0200 (CEST)
In-Reply-To: <s5hfy5qp3gr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-704422492-1179867749=:5158
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Mon, 21 May 2007, Takashi Iwai wrote:

> At Fri, 18 May 2007 16:42:51 +0200 (CEST),
> Tomas Pospisek's Mailing Lists wrote:
>>
>> Since I got no feedback neither here nor on the users list, may I ask why?
>>
>> * is it that nobody knows the answer to my question?
>> * or is it because the question is stupid (as in: read the FAQ, the wiki,
>>    the archive and use google (all of which did not help me btw.))
>
> Because you pasted the whole things below your signature.
> I didn't read texts below the signature because they are usually
> quoted texts.

Thanks a lot for your reply and sorry for that.

> Regarding the alsactl problem.  When alsactl returns 'no state is
> present', then it's not necessarily a driver problem but could be
> rather a system problem.  At least, you have to figure out what is the
> cause. For example, check /proc/asound/cards whether the driver is
> really loaded when you call alsactl.

Well, actually I figured out one cause of the problem, namely that alsactl 
wasn't able to access the configuration file. My dumb, but nevertheless, 
alsactl could be way clearer about telling the user what's wrong.

I suggest the attached patches to improve the comprehensibility of 
alsactl's (error-)behaveour.


Description of patches:

* diff_display_error_on_failing_open_in_load_state:
   Tells the user that it was not able to open the config file with the
   precise error message.

* diff_more_explicit_open_w_error_message:
   Include more explicit error message when open config file in write
   mode (this is for the "names" command)

* diff_more_explicit_open_w_error_message2
   same as last patch, this time for the store command


Other little patches:

* diff_missing_space_in_help:
   adds a space in the help text between "restore" and "<card>" and indents
   the rest of the text accordingly to fit

* diff4_display_help_for_names_command:
   shortly explain the "names" command in the help text


*t

--
-----------------------------------------------------------
   Tomas Pospisek
   http://sourcepole.com -  Linux & Open Source Solutions
-----------------------------------------------------------
--8323328-704422492-1179867749=:5158
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff_display_error_on_failing_open_in_load_state
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0705222302290.5158@localhost>
Content-Description: 
Content-Disposition: attachment; filename=diff_display_error_on_failing_open_in_load_state

ZGlmZiAtdSBzdGF0ZS5jIHN0YXRlLmMNCi0tLSBzdGF0ZS5jCTIwMDYtMDkt
MjkgMTM6NTM6MjYuMDAwMDAwMDAwICswMjAwDQorKysgc3RhdGUuYwkyMDA3
LTA1LTIyIDIyOjEyOjIxLjAwMDAwMDAwMCArMDIwMA0KQEAgLTEzMTIsNyAr
MTMxMiwxMCBAQA0KIAkJCWVycm9yKCJzbmRfY29uZmlnX2xvYWQgZXJyb3I6
ICVzIiwgc25kX3N0cmVycm9yKGVycikpOw0KIAkJCXJldHVybiBlcnI7DQog
CQl9DQotCX0NCisJfSBlbHNlIHsNCisJICBlcnJvcigiQ2Fubm90IG9wZW4g
JXMgZm9yIHJlYWRpbmc6ICVzIiwgZmlsZSwgc25kX3N0cmVycm9yKGVycikp
Ow0KKyAgICAgICAgICByZXR1cm4gZXJyOw0KKyAgICAgICAgfQ0KIA0KIAlp
ZiAoIWNhcmRuYW1lKSB7DQogCQlpbnQgY2FyZCwgZmlyc3QgPSAxOw0K

--8323328-704422492-1179867749=:5158
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff_missing_space_in_help
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0705222302291.5158@localhost>
Content-Description: 
Content-Disposition: attachment; filename=diff_missing_space_in_help

LS0tIGFsc2FjdGwuYy5vcmlnCTIwMDYtMDktMjkgMTM6NTM6MjYuMDAwMDAw
MDAwICswMjAwDQorKysgYWxzYWN0bC5jCTIwMDctMDUtMjIgMjI6MDM6MzYu
MDAwMDAwMDAwICswMjAwDQpAQCAtNDEsMTYgKzQxLDE2IEBADQogew0KIAlw
cmludGYoIlVzYWdlOiBhbHNhY3RsIDxvcHRpb25zPiBjb21tYW5kXG4iKTsN
CiAJcHJpbnRmKCJcbkF2YWlsYWJsZSBvcHRpb25zOlxuIik7DQotCXByaW50
ZigiICAtaCwtLWhlbHAgICAgICAgdGhpcyBoZWxwXG4iKTsNCi0JcHJpbnRm
KCIgIC1mLC0tZmlsZSAjICAgICBjb25maWd1cmF0aW9uIGZpbGUgKGRlZmF1
bHQgIiBTWVNfQVNPVU5EUkMgIiBvciAiIFNZU19BU09VTkROQU1FUyAiKVxu
Iik7DQotCXByaW50ZigiICAtRiwtLWZvcmNlICAgICAgdHJ5IHRvIHJlc3Rv
cmUgdGhlIG1hdGNoaW5nIGNvbnRyb2xzIGFzIG11Y2ggYXMgcG9zc2libGVc
biIpOw0KLQlwcmludGYoIiAgLWQsLS1kZWJ1ZyAgICAgIGRlYnVnIG1vZGVc
biIpOw0KLQlwcmludGYoIiAgLXYsLS12ZXJzaW9uICAgIHByaW50IHZlcnNp
b24gb2YgdGhpcyBwcm9ncmFtXG4iKTsNCisJcHJpbnRmKCIgIC1oLC0taGVs
cCAgICAgICAgdGhpcyBoZWxwXG4iKTsNCisJcHJpbnRmKCIgIC1mLC0tZmls
ZSAjICAgICAgY29uZmlndXJhdGlvbiBmaWxlIChkZWZhdWx0ICIgU1lTX0FT
T1VORFJDICIgb3IgIiBTWVNfQVNPVU5ETkFNRVMgIilcbiIpOw0KKwlwcmlu
dGYoIiAgLUYsLS1mb3JjZSAgICAgICB0cnkgdG8gcmVzdG9yZSB0aGUgbWF0
Y2hpbmcgY29udHJvbHMgYXMgbXVjaCBhcyBwb3NzaWJsZVxuIik7DQorCXBy
aW50ZigiICAtZCwtLWRlYnVnICAgICAgIGRlYnVnIG1vZGVcbiIpOw0KKwlw
cmludGYoIiAgLXYsLS12ZXJzaW9uICAgICBwcmludCB2ZXJzaW9uIG9mIHRo
aXMgcHJvZ3JhbVxuIik7DQogCXByaW50ZigiXG5BdmFpbGFibGUgY29tbWFu
ZHM6XG4iKTsNCi0JcHJpbnRmKCIgIHN0b3JlIDxjYXJkICM+ICBzYXZlIGN1
cnJlbnQgZHJpdmVyIHNldHVwIGZvciBvbmUgb3IgZWFjaCBzb3VuZGNhcmRz
XG4iKTsNCi0JcHJpbnRmKCIgICAgICAgICAgICAgICAgICB0byBjb25maWd1
cmF0aW9uIGZpbGVcbiIpOw0KLQlwcmludGYoIiAgcmVzdG9yZTxjYXJkICM+
IGxvYWQgY3VycmVudCBkcml2ZXIgc2V0dXAgZm9yIG9uZSBvciBlYWNoIHNv
dW5kY2FyZHNcbiIpOw0KLQlwcmludGYoIiAgICAgICAgICAgICAgICAgIGZy
b20gY29uZmlndXJhdGlvbiBmaWxlXG4iKTsNCisJcHJpbnRmKCIgIHN0b3Jl
ICAgPGNhcmQgIz4gc2F2ZSBjdXJyZW50IGRyaXZlciBzZXR1cCBmb3Igb25l
IG9yIGVhY2ggc291bmRjYXJkc1xuIik7DQorCXByaW50ZigiICAgICAgICAg
ICAgICAgICAgIHRvIGNvbmZpZ3VyYXRpb24gZmlsZVxuIik7DQorCXByaW50
ZigiICByZXN0b3JlIDxjYXJkICM+IGxvYWQgY3VycmVudCBkcml2ZXIgc2V0
dXAgZm9yIG9uZSBvciBlYWNoIHNvdW5kY2FyZHNcbiIpOw0KKwlwcmludGYo
IiAgICAgICAgICAgICAgICAgICBmcm9tIGNvbmZpZ3VyYXRpb24gZmlsZVxu
Iik7DQogfQ0KIA0KIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10p
DQo=

--8323328-704422492-1179867749=:5158
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff4_display_help_for_names_command
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0705222302292.5158@localhost>
Content-Description: 
Content-Disposition: attachment; filename=diff4_display_help_for_names_command

ZGlmZiAtdSBhbHNhY3RsLmMgYWxzYWN0bC5jDQotLS0gYWxzYWN0bC5jCTIw
MDctMDUtMjIgMjI6MDM6MzYuMDAwMDAwMDAwICswMjAwDQorKysgYWxzYWN0
bC5jCTIwMDctMDUtMjIgMjI6MDY6NDMuMDAwMDAwMDAwICswMjAwDQpAQCAt
NTEsNiArNTEsOCBAQA0KIAlwcmludGYoIiAgICAgICAgICAgICAgICAgICB0
byBjb25maWd1cmF0aW9uIGZpbGVcbiIpOw0KIAlwcmludGYoIiAgcmVzdG9y
ZSA8Y2FyZCAjPiBsb2FkIGN1cnJlbnQgZHJpdmVyIHNldHVwIGZvciBvbmUg
b3IgZWFjaCBzb3VuZGNhcmRzXG4iKTsNCiAJcHJpbnRmKCIgICAgICAgICAg
ICAgICAgICAgZnJvbSBjb25maWd1cmF0aW9uIGZpbGVcbiIpOw0KKwlwcmlu
dGYoIiAgbmFtZXMgICA8Y2FyZCAjPiBkdW1wIGluZm9ybWF0aW9uIGFib3V0
IGFsbCB0aGUga25vd24gcHJlc2VudCAoc3ViLSlkZXZpY2VzXG4iKTsNCisJ
cHJpbnRmKCIgICAgICAgICAgICAgICAgICAgaW50byBjb25maWd1cmF0aW9u
IGZpbGVcbiIpOw0KIH0NCiANCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
YXJndltdKQ0K

--8323328-704422492-1179867749=:5158
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff_more_explicit_open_w_error_message
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0705222302293.5158@localhost>
Content-Description: 
Content-Disposition: attachment; filename=diff_more_explicit_open_w_error_message

LS0tIG5hbWVzLmMub3JpZwkyMDA2LTA5LTI5IDEzOjUzOjI2LjAwMDAwMDAw
MCArMDIwMA0KKysrIG5hbWVzLmMJMjAwNy0wNS0yMiAyMjoxNToyOS4wMDAw
MDAwMDAgKzAyMDANCkBAIC01MzUsNyArNTM1LDcgQEANCiAJCQllcnIgPSBz
bmRfb3V0cHV0X3N0ZGlvX29wZW4oJm91dCwgY2ZnZmlsZSwgIncrIik7DQog
CQl9DQogCQlpZiAoZXJyIDwgMCkgew0KLQkJCWVycm9yKCJDYW5ub3Qgb3Bl
biAlcyBmb3Igd3JpdGluZyIsIGNmZ2ZpbGUpOw0KKwkJCWVycm9yKCJDYW5u
b3Qgb3BlbiAlcyBmb3Igd3JpdGluZzogJXMiLCBjZmdmaWxlLCBzbmRfc3Ry
ZXJyb3IoZXJyKSk7DQogCQkJcmV0dXJuIC1lcnJubzsNCiAJCX0NCiAJCWVy
ciA9IHNuZF9jb25maWdfc2F2ZShjb25maWcsIG91dCk7DQo=

--8323328-704422492-1179867749=:5158
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff_more_explicit_open_w_error_message2
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0705222302294.5158@localhost>
Content-Description: 
Content-Disposition: attachment; filename=diff_more_explicit_open_w_error_message2

ZGlmZiAtdSBzdGF0ZS5jIHN0YXRlLmMNCi0tLSBzdGF0ZS5jCTIwMDctMDUt
MjIgMjI6MTI6MjEuMDAwMDAwMDAwICswMjAwDQorKysgc3RhdGUuYwkyMDA3
LTA1LTIyIDIyOjE5OjM3LjAwMDAwMDAwMCArMDIwMA0KQEAgLTEyNzgsNyAr
MTI3OCw3IEBADQogCWVsc2UNCiAJCWVyciA9IHNuZF9vdXRwdXRfc3RkaW9f
b3Blbigmb3V0LCBmaWxlLCAidyIpOw0KIAlpZiAoZXJyIDwgMCkgew0KLQkJ
ZXJyb3IoIkNhbm5vdCBvcGVuICVzIGZvciB3cml0aW5nIiwgZmlsZSk7DQor
CQllcnJvcigiQ2Fubm90IG9wZW4gJXMgZm9yIHdyaXRpbmc6ICVzIiwgZmls
ZSwgc25kX3N0cmVycm9yKGVycikpOw0KIAkJcmV0dXJuIC1lcnJubzsNCiAJ
fQ0KIAllcnIgPSBzbmRfY29uZmlnX3NhdmUoY29uZmlnLCBvdXQpOw0K

--8323328-704422492-1179867749=:5158
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323328-704422492-1179867749=:5158--
