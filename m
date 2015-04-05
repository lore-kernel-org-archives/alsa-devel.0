From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/10] fix error return code
Date: Sun,  5 Apr 2015 13:38:25 +0200
Message-ID: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These patches fix cases where the return code appears to be unintentially
nonnegative.

The complete semantic match that finds the problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@ok exists@
identifier f,ret,i;
expression e;
constant c;
@@

f(...) {
<+...
(
return -c@i;
|
ret = -c@i;
... when != ret = e
return ret;
|
if (ret < 0) { ... return ret; }
)
...+> }

@r exists@
identifier ret,l,ok.f;
expression e1,e2,e3;
statement S;
position p1,p2,p3;
@@

f(...) {
... when any
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
(
 if (<+... ret = e3 ...+>) S
|
 if (<+... &ret ...+>) S
|
if@p2(...)
 {
  ... when != ret = e2
      when forall
 return@p3 ret;
}
)
... when any
}

@bad exists@
position r.p1,r.p2;
statement S1,S2;
identifier r.ret;
expression e1;
@@

(
if@p1 (\(ret < 0\|ret != 0\)) S1
|
ret@p1 = 0
)
... when any
ret = e1
... when any
if@p2(...) S2

@bad2@
position r.p1,r.p2;
identifier r.ret;
expression e1;
statement S2;
@@

ret@p1 = 0
... when != if (...) { ... ret = e1 ... return ret; }
    when any
if@p2(...) S2


@script:python depends on !bad && !bad2@
p1 << r.p1;
p2 << r.p2;
p3 << r.p3;
@@

cocci.print_main("",p1)
cocci.print_secs("",p2)
cocci.print_secs("",p3)
// </smpl>
