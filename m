From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa timer slippage
Date: Wed, 17 Dec 2003 16:13:44 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312171610420.2053@pnote.perex-int.cz>
References: <E1AVXB7-00025m-JG@sc8-sf-list2.sourceforge.net>
 <200312150230.33546.plcl@telefonica.net> <200312150916.03357.cannam@all-day-breakfast.com>
 <200312150953.08559.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463789468-215499052-1071674024=:2053"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312150953.08559.cannam@all-day-breakfast.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Cannam <cannam@all-day-breakfast.com>
Cc: Pedro Lopez-Cabanillas <plcl@telefonica.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463789468-215499052-1071674024=:2053
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 15 Dec 2003, Chris Cannam wrote:

> On Monday 15 Dec 2003 9:16 am, Chris Cannam wrote:
> > This seems to suggest that the default system-based timer is doing
> > something a bit naive, like assuming it was called back on time
> > without actually checking.
> 
> Hmm yes, even this crappy little patch to alsa-kernel/core/timer.c 
> (gross adjustment to each system timer tick according to how late the 
> previous one was) improves things for me.  With this the timer still 
> slips, but never quite enough to be audible in a MIDI-only stream.  
> The PCM clock is still much much better though.
> 
> @@ -940,9 +940,16 @@
>         return 1000000000L / HZ;
>  }
> 
> +static long lateness;
> +
>  static void snd_timer_s_function(unsigned long data)
>  {
> +       struct timer_list *tlist;
>         snd_timer_t *timer = (snd_timer_t *)data;
> +
> +       tlist = (struct timer_list *) timer->private_data;
> +       lateness = (long)jiffies - (long)tlist->expires;
> +
>         snd_timer_interrupt(timer, timer->sticks);
>  }
> 
> @@ -951,7 +958,7 @@
>         struct timer_list *tlist;
> 
>         tlist = (struct timer_list *) timer->private_data;
> -       tlist->expires = jiffies + timer->sticks;
> +       tlist->expires = jiffies + timer->sticks - lateness;
>         add_timer(tlist);
>         return 0;
>  }

Thanks for insigh to the problem. Can you try the attached patch?
(It's also in CVS.)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
---1463789468-215499052-1071674024=:2053
Content-Type: TEXT/plain; charset=US-ASCII; name="out.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0312171613440.2053@pnote.perex-int.cz>
Content-Description: 
Content-Disposition: attachment; filename="out.txt"

SW5kZXg6IHRpbWVyLmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBm
aWxlOiAvY3Zzcm9vdC9hbHNhL2Fsc2Eta2VybmVsL2NvcmUvdGltZXIuYyx2
DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNTINCnJldHJpZXZpbmcgcmV2aXNp
b24gMS41NQ0KZGlmZiAtdSAtcjEuNTIgLXIxLjU1DQotLS0gdGltZXIuYwky
MyBPY3QgMjAwMyAxNDozNDo1MiAtMDAwMAkxLjUyDQorKysgdGltZXIuYwkx
NyBEZWMgMjAwMyAxNToxNDozMyAtMDAwMAkxLjU1DQpAQCAtOTM1LDYgKzkz
NSwxNCBAQA0KICAqICBTeXN0ZW0gdGltZXINCiAgKi8NCiANCitzdHJ1Y3Qg
c25kX3RpbWVyX3N5c3RlbV9wcml2YXRlIHsNCisJc3RydWN0IHRpbWVyX2xp
c3QgdGxpc3Q7DQorCXN0cnVjdCB0aW1lciAqIHRpbWVyOw0KKwl1bnNpZ25l
ZCBsb25nIGxhc3RfZXhwaXJlczsNCisJdW5zaWduZWQgbG9uZyBsYXN0X2pp
ZmZpZXM7DQorCXVuc2lnbmVkIGxvbmcgY29ycmVjdGlvbjsNCit9Ow0KKw0K
IHVuc2lnbmVkIGludCBzbmRfdGltZXJfc3lzdGVtX3Jlc29sdXRpb24odm9p
ZCkNCiB7DQogCXJldHVybiAxMDAwMDAwMDAwTCAvIEhaOw0KQEAgLTk0Mywy
NiArOTUxLDQ0IEBADQogc3RhdGljIHZvaWQgc25kX3RpbWVyX3NfZnVuY3Rp
b24odW5zaWduZWQgbG9uZyBkYXRhKQ0KIHsNCiAJc25kX3RpbWVyX3QgKnRp
bWVyID0gKHNuZF90aW1lcl90ICopZGF0YTsNCi0Jc25kX3RpbWVyX2ludGVy
cnVwdCh0aW1lciwgdGltZXItPnN0aWNrcyk7DQorCXN0cnVjdCBzbmRfdGlt
ZXJfc3lzdGVtX3ByaXZhdGUgKnByaXYgPSB0aW1lci0+cHJpdmF0ZV9kYXRh
Ow0KKwl1bnNpZ25lZCBsb25nIGppZmYgPSBqaWZmaWVzOw0KKwlpZiAodGlt
ZV9hZnRlcihqaWZmLCBwcml2LT5sYXN0X2V4cGlyZXMpKQ0KKwkJcHJpdi0+
Y29ycmVjdGlvbiA9IChsb25nKWppZmYgLSAobG9uZylwcml2LT5sYXN0X2V4
cGlyZXM7DQorCXNuZF90aW1lcl9pbnRlcnJ1cHQodGltZXIsIChsb25nKWpp
ZmYgLSAobG9uZylwcml2LT5sYXN0X2ppZmZpZXMpOw0KIH0NCiANCiBzdGF0
aWMgaW50IHNuZF90aW1lcl9zX3N0YXJ0KHNuZF90aW1lcl90ICogdGltZXIp
DQogew0KLQlzdHJ1Y3QgdGltZXJfbGlzdCAqdGxpc3Q7DQorCXN0cnVjdCBz
bmRfdGltZXJfc3lzdGVtX3ByaXZhdGUgKnByaXY7DQorCXVuc2lnbmVkIGxv
bmcgbmppZmY7DQogDQotCXRsaXN0ID0gKHN0cnVjdCB0aW1lcl9saXN0ICop
IHRpbWVyLT5wcml2YXRlX2RhdGE7DQotCXRsaXN0LT5leHBpcmVzID0gamlm
ZmllcyArIHRpbWVyLT5zdGlja3M7DQotCWFkZF90aW1lcih0bGlzdCk7DQor
CXByaXYgPSAoc3RydWN0IHNuZF90aW1lcl9zeXN0ZW1fcHJpdmF0ZSAqKSB0
aW1lci0+cHJpdmF0ZV9kYXRhOw0KKwluamlmZiA9IChwcml2LT5sYXN0X2pp
ZmZpZXMgPSBqaWZmaWVzKTsNCisJaWYgKHByaXYtPmNvcnJlY3Rpb24gPiB0
aW1lci0+c3RpY2tzIC0gMSkgew0KKwkJcHJpdi0+Y29ycmVjdGlvbiAtPSB0
aW1lci0+c3RpY2tzIC0gMTsNCisJCW5qaWZmKys7DQorCX0gZWxzZSB7DQor
CQluamlmZiArPSB0aW1lci0+c3RpY2tzIC0gcHJpdi0+Y29ycmVjdGlvbjsN
CisJCXByaXYtPmNvcnJlY3Rpb24gLT0gdGltZXItPnN0aWNrczsNCisJfQ0K
Kwlwcml2LT5sYXN0X2V4cGlyZXMgPSBwcml2LT50bGlzdC5leHBpcmVzID0g
bmppZmY7DQorCWFkZF90aW1lcigmcHJpdi0+dGxpc3QpOw0KIAlyZXR1cm4g
MDsNCiB9DQogDQogc3RhdGljIGludCBzbmRfdGltZXJfc19zdG9wKHNuZF90
aW1lcl90ICogdGltZXIpDQogew0KLQlzdHJ1Y3QgdGltZXJfbGlzdCAqdGxp
c3Q7DQorCXN0cnVjdCBzbmRfdGltZXJfc3lzdGVtX3ByaXZhdGUgKnByaXY7
DQorCXVuc2lnbmVkIGxvbmcgamlmZjsNCiANCi0JdGxpc3QgPSAoc3RydWN0
IHRpbWVyX2xpc3QgKikgdGltZXItPnByaXZhdGVfZGF0YTsNCi0JZGVsX3Rp
bWVyKHRsaXN0KTsNCi0JdGltZXItPnN0aWNrcyA9IHRsaXN0LT5leHBpcmVz
IC0gamlmZmllczsNCisJcHJpdiA9IChzdHJ1Y3Qgc25kX3RpbWVyX3N5c3Rl
bV9wcml2YXRlICopIHRpbWVyLT5wcml2YXRlX2RhdGE7DQorCWRlbF90aW1l
cigmcHJpdi0+dGxpc3QpOw0KKwlqaWZmID0gamlmZmllczsNCisJaWYgKHRp
bWVfYmVmb3JlKGppZmYsIHByaXYtPmxhc3RfZXhwaXJlcykpDQorCQl0aW1l
ci0+c3RpY2tzID0gcHJpdi0+bGFzdF9leHBpcmVzIC0gamlmZjsNCisJZWxz
ZQ0KKwkJdGltZXItPnN0aWNrcyA9IDE7DQogCXJldHVybiAwOw0KIH0NCiAN
CkBAIC05ODQsMjIgKzEwMTAsMjIgQEANCiBzdGF0aWMgaW50IHNuZF90aW1l
cl9yZWdpc3Rlcl9zeXN0ZW0odm9pZCkNCiB7DQogCXNuZF90aW1lcl90ICp0
aW1lcjsNCi0Jc3RydWN0IHRpbWVyX2xpc3QgKnRsaXN0Ow0KKwlzdHJ1Y3Qg
c25kX3RpbWVyX3N5c3RlbV9wcml2YXRlICpwcml2Ow0KIAlpbnQgZXJyOw0K
IA0KIAlpZiAoKGVyciA9IHNuZF90aW1lcl9nbG9iYWxfbmV3KCJzeXN0ZW0i
LCBTTkRSVl9USU1FUl9HTE9CQUxfU1lTVEVNLCAmdGltZXIpKSA8IDApDQog
CQlyZXR1cm4gZXJyOw0KIAlzdHJjcHkodGltZXItPm5hbWUsICJzeXN0ZW0g
dGltZXIiKTsNCiAJdGltZXItPmh3ID0gc25kX3RpbWVyX3N5c3RlbTsNCi0J
dGxpc3QgPSAoc3RydWN0IHRpbWVyX2xpc3QgKikgc25kX2tjYWxsb2Moc2l6
ZW9mKHN0cnVjdCB0aW1lcl9saXN0KSwgR0ZQX0tFUk5FTCk7DQotCWlmICh0
bGlzdCA9PSBOVUxMKSB7DQorCXByaXYgPSAoc3RydWN0IHNuZF90aW1lcl9z
eXN0ZW1fcHJpdmF0ZSAqKSBzbmRfa2NhbGxvYyhzaXplb2Yoc3RydWN0IHNu
ZF90aW1lcl9zeXN0ZW1fcHJpdmF0ZSksIEdGUF9LRVJORUwpOw0KKwlpZiAo
cHJpdiA9PSBOVUxMKSB7DQogCQlzbmRfdGltZXJfZnJlZSh0aW1lcik7DQog
CQlyZXR1cm4gLUVOT01FTTsNCiAJfQ0KLQlpbml0X3RpbWVyKHRsaXN0KTsN
Ci0JdGxpc3QtPmZ1bmN0aW9uID0gc25kX3RpbWVyX3NfZnVuY3Rpb247DQot
CXRsaXN0LT5kYXRhID0gKHVuc2lnbmVkIGxvbmcpIHRpbWVyOw0KLQl0aW1l
ci0+cHJpdmF0ZV9kYXRhID0gdGxpc3Q7DQorCWluaXRfdGltZXIoJnByaXYt
PnRsaXN0KTsNCisJcHJpdi0+dGxpc3QuZnVuY3Rpb24gPSBzbmRfdGltZXJf
c19mdW5jdGlvbjsNCisJcHJpdi0+dGxpc3QuZGF0YSA9ICh1bnNpZ25lZCBs
b25nKSB0aW1lcjsNCisJdGltZXItPnByaXZhdGVfZGF0YSA9IHByaXY7DQog
CXRpbWVyLT5wcml2YXRlX2ZyZWUgPSBzbmRfdGltZXJfZnJlZV9zeXN0ZW07
DQogCXJldHVybiBzbmRfdGltZXJfZ2xvYmFsX3JlZ2lzdGVyKHRpbWVyKTsN
CiB9DQo=

---1463789468-215499052-1071674024=:2053--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
