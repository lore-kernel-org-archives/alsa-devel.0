From: Marko Lindqvist <cazfi74@gmail.com>
Subject: alsa-util fix (Re: [PATCH] alsa-lib: Fix build with
	automake-1.13)
Date: Sat, 12 Jan 2013 10:16:45 +0200
Message-ID: <CAF6bG8cTGFN5eawMM++cJq3CmD75U3SsJwG9J2_Lvj7GfobsQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf307d04265f90e404d31308bc
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 473F626509E
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2013 09:16:46 +0100 (CET)
Received: by mail-vc0-f181.google.com with SMTP id gb30so2119608vcb.26
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2013 00:16:45 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--20cf307d04265f90e404d31308bc
Content-Type: text/plain; charset=UTF-8

On 4 January 2013 01:40, Marko Lindqvist <cazfi74@gmail.com> wrote:
> Automake-1.13 removed long obsolete AM_CONFIG_HEADER completely (
> http://lists.gnu.org/archive/html/automake/2012-12/msg00038.html ) and
> errors out upon seeing it.
>
> Attached patch replaces it with proper AC_CONFIG_HEADERS.
>
>
> I'm not subscribed to the list.

I'm mass-submitting automake-1.13 fixes. Please see what you can do so
I don't need to do the same when automake-1.14 comes out:
http://cazfi.livejournal.com/195108.html


 - ML

--20cf307d04265f90e404d31308bc
Content-Type: application/octet-stream;
	name="obsolete_automake_macros.patch"
Content-Disposition: attachment; filename="obsolete_automake_macros.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hbuhe69q1

U2lnbmVkLW9mZi1ieTogTWFya28gTGluZHF2aXN0IDxjYXpmaTc0QGdtYWlsLmNvbT4KZGlmZiAt
TnVyZCBhbHNhLXV0aWxzLTEuMC4yNS9jb25maWd1cmUuaW4gYWxzYS11dGlscy0xLjAuMjUvY29u
ZmlndXJlLmluCi0tLSBhbHNhLXV0aWxzLTEuMC4yNS9jb25maWd1cmUuaW4JMjAxMi0wMS0yNSAx
MTo0Mzo0OC4wMDAwMDAwMDAgKzAyMDAKKysrIGFsc2EtdXRpbHMtMS4wLjI1L2NvbmZpZ3VyZS5p
bgkyMDEzLTAxLTEyIDEwOjExOjUxLjQwMTQ5ODcyMiArMDIwMApAQCAtMjY5LDcgKzI2OSw3IEBA
CiAgIFRFU1RTT1VORD0iJGRpci90ZXN0LndhdiIpCiBBQ19TVUJTVChURVNUU09VTkQpCiAKLUFN
X0NPTkZJR19IRUFERVIoaW5jbHVkZS9hY29uZmlnLmgpCitBQ19DT05GSUdfSEVBREVSUyhpbmNs
dWRlL2Fjb25maWcuaCkKIAogZG5sIENoZWNrcyBmb3IgdHlwZWRlZnMsIHN0cnVjdHVyZXMsIGFu
ZCBjb21waWxlciBjaGFyYWN0ZXJpc3RpY3MuCiBBQ19DX0NPTlNUCg==
--20cf307d04265f90e404d31308bc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf307d04265f90e404d31308bc--
