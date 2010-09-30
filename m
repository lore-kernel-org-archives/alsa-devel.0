From: Stas Sergeev <stsp@aknet.ru>
Subject: namehint: Evaluate more possibilities for hw devices
Date: Thu, 30 Sep 2010 20:11:43 +0400
Message-ID: <4CA4B6BF.3080503@aknet.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070700060201050705040002"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E24910393B
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 18:11:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070700060201050705040002
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  Hi Jaroslav.

I updated the alsa-lib from git, and "aplay -L"
no longer shows some PCMs it used to list before.
I tracked this down to this commit:
---
commit 97d25c0766405453d3c298bd51dd4916121a4f6a
Author: Jaroslav Kysela <perex@perex.cz>
Date:   Fri Aug 20 10:31:17 2010 +0200

     namehint: Evaluate more possibilities for hw devices
---

Attached are the outputs before and after the commit.
So why some devices are now missing?

--------------070700060201050705040002
Content-Type: text/plain;
 name="before.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="before.log"

ZGVmYXVsdAogICAgRGVmYXVsdApmcm9udDpDQVJEPU5WaWRpYSxERVY9MAogICAgSERBIE5W
aWRpYSwgQUxDODg3IEFuYWxvZwogICAgRnJvbnQgc3BlYWtlcnMKc3Vycm91bmQ0MDpDQVJE
PU5WaWRpYSxERVY9MAogICAgSERBIE5WaWRpYSwgQUxDODg3IEFuYWxvZwogICAgNC4wIFN1
cnJvdW5kIG91dHB1dCB0byBGcm9udCBhbmQgUmVhciBzcGVha2VycwpzdXJyb3VuZDQxOkNB
UkQ9TlZpZGlhLERFVj0wCiAgICBIREEgTlZpZGlhLCBBTEM4ODcgQW5hbG9nCiAgICA0LjEg
U3Vycm91bmQgb3V0cHV0IHRvIEZyb250LCBSZWFyIGFuZCBTdWJ3b29mZXIgc3BlYWtlcnMK
c3Vycm91bmQ1MDpDQVJEPU5WaWRpYSxERVY9MAogICAgSERBIE5WaWRpYSwgQUxDODg3IEFu
YWxvZwogICAgNS4wIFN1cnJvdW5kIG91dHB1dCB0byBGcm9udCwgQ2VudGVyIGFuZCBSZWFy
IHNwZWFrZXJzCnN1cnJvdW5kNTE6Q0FSRD1OVmlkaWEsREVWPTAKICAgIEhEQSBOVmlkaWEs
IEFMQzg4NyBBbmFsb2cKICAgIDUuMSBTdXJyb3VuZCBvdXRwdXQgdG8gRnJvbnQsIENlbnRl
ciwgUmVhciBhbmQgU3Vid29vZmVyIHNwZWFrZXJzCnN1cnJvdW5kNzE6Q0FSRD1OVmlkaWEs
REVWPTAKICAgIEhEQSBOVmlkaWEsIEFMQzg4NyBBbmFsb2cKICAgIDcuMSBTdXJyb3VuZCBv
dXRwdXQgdG8gRnJvbnQsIENlbnRlciwgU2lkZSwgUmVhciBhbmQgV29vZmVyIHNwZWFrZXJz
CmllYzk1ODpDQVJEPU5WaWRpYSxERVY9MAogICAgSERBIE5WaWRpYSwgQUxDODg3IERpZ2l0
YWwKICAgIElFQzk1OCAoUy9QRElGKSBEaWdpdGFsIEF1ZGlvIE91dHB1dApoZG1pOkNBUkQ9
SERNSQogICAgSERBIEFUSSBIRE1JLCBBVEkgSERNSQogICAgSERNSSBBdWRpbyBPdXRwdXQK
ZnJvbnQ6Q0FSRD1wY3NwLERFVj0wCiAgICBwY3NwLCBwY3NwCiAgICBGcm9udCBzcGVha2Vy
cwpmcm9udDpDQVJEPUR1bW15LERFVj0wCiAgICBEdW1teSwgRHVtbXkgUENNCiAgICBGcm9u
dCBzcGVha2Vycwo=
--------------070700060201050705040002
Content-Type: text/plain;
 name="after.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="after.log"

ZGVmYXVsdAogICAgRGVmYXVsdApmcm9udDpDQVJEPU5WaWRpYSxERVY9MAogICAgSERBIE5W
aWRpYSwgQUxDODg3IEFuYWxvZwogICAgRnJvbnQgc3BlYWtlcnMKc3Vycm91bmQ0MDpDQVJE
PU5WaWRpYSxERVY9MAogICAgSERBIE5WaWRpYSwgQUxDODg3IEFuYWxvZwogICAgNC4wIFN1
cnJvdW5kIG91dHB1dCB0byBGcm9udCBhbmQgUmVhciBzcGVha2VycwpzdXJyb3VuZDQxOkNB
UkQ9TlZpZGlhLERFVj0wCiAgICBIREEgTlZpZGlhLCBBTEM4ODcgQW5hbG9nCiAgICA0LjEg
U3Vycm91bmQgb3V0cHV0IHRvIEZyb250LCBSZWFyIGFuZCBTdWJ3b29mZXIgc3BlYWtlcnMK
c3Vycm91bmQ1MDpDQVJEPU5WaWRpYSxERVY9MAogICAgSERBIE5WaWRpYSwgQUxDODg3IEFu
YWxvZwogICAgNS4wIFN1cnJvdW5kIG91dHB1dCB0byBGcm9udCwgQ2VudGVyIGFuZCBSZWFy
IHNwZWFrZXJzCnN1cnJvdW5kNTE6Q0FSRD1OVmlkaWEsREVWPTAKICAgIEhEQSBOVmlkaWEs
IEFMQzg4NyBBbmFsb2cKICAgIDUuMSBTdXJyb3VuZCBvdXRwdXQgdG8gRnJvbnQsIENlbnRl
ciwgUmVhciBhbmQgU3Vid29vZmVyIHNwZWFrZXJzCnN1cnJvdW5kNzE6Q0FSRD1OVmlkaWEs
REVWPTAKICAgIEhEQSBOVmlkaWEsIEFMQzg4NyBBbmFsb2cKICAgIDcuMSBTdXJyb3VuZCBv
dXRwdXQgdG8gRnJvbnQsIENlbnRlciwgU2lkZSwgUmVhciBhbmQgV29vZmVyIHNwZWFrZXJz
CmllYzk1ODpDQVJEPU5WaWRpYSxERVY9MAogICAgSERBIE5WaWRpYSwgQUxDODg3IERpZ2l0
YWwKICAgIElFQzk1OCAoUy9QRElGKSBEaWdpdGFsIEF1ZGlvIE91dHB1dAo=
--------------070700060201050705040002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070700060201050705040002--
