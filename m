From: sajeesh sidharthan <sajeesh.sidharthan@yahoo.com>
Subject: [alsa-ucm] segfault at __list_del function in list.h
Date: Thu, 20 Jun 2013 00:23:36 -0700 (PDT)
Message-ID: <1371713016.28790.YahooMailNeo@web121506.mail.ne1.yahoo.com>
Reply-To: sajeesh sidharthan <sajeesh.sidharthan@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm13.bullet.mail.ne1.yahoo.com (nm13.bullet.mail.ne1.yahoo.com
 [98.138.90.76]) by alsa0.perex.cz (Postfix) with ESMTP id 47BFC265208
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2013 09:23:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello.

I am testing pulseaudio ucm. I have faced a crash when active ucm device li=
st empty.

Please let me know if following fix can be checked in alsa-lib-1.0.25/inclu=
de/list.h

old code:


static __inline__ void list_del(struct list_head *entry)
{
=A0=A0=A0 =A0=A0=A0 __list_del(entry->prev, entry->next);
}

new code:

static __inline__ void list_del(struct list_head *entry)
{
=A0=A0=A0 if(entry->prev && entry->next)
=A0=A0=A0 =A0=A0=A0 __list_del(entry->prev, entry->next);
}


Sajeesh
