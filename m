From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: Problem with aloop
Date: Tue, 13 May 2008 08:51:39 -0300
Message-ID: <482980CB.5070601@tet.com.br>
References: <d5eabee70805130043s79f68c8yf5e971d147827360@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail4.tet.com.br [201.47.194.114])
	by alsa0.perex.cz (Postfix) with ESMTP id DCFF724AEB
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:51:43 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id AC207120022
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 08:51:42 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id A77E5120020
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 08:51:39 -0300 (BRST)
In-Reply-To: <d5eabee70805130043s79f68c8yf5e971d147827360@mail.gmail.com>
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

I had some problems until I could figure it out how to configure alsa =

properly in /etc/asound.conf. Maybe this could be your problem? What is =

your alsa version? I heard that aloop didn't work well until 1.0.15, or =

such (alsa guys: is this true?).

Benjamin van den Hout escreveu:
> Gustavo da Silva Serra wrote:
>
> Well, I discovered that only xinelib has this problem. Xmms and
>   =

>> alsaplayer, for example, don't have this issue. I am testing VLC and it
>> seems to work fine. I am not surprised, since the xine source code that
>> deals with alsa is huge and ugly, it must be very hard to mantain that.
>>
>>     =

>
> Thanks for your reply! I did some more testing and I can reproduce it as
> well with the 8bit mode, it occurrs less frequently. When I switch back to
> 16 bit it takes only a few tries with aplay to get the hiccups. So it see=
ms
> it is a bit more tricky than I initially thought. Xine can be a strange
> beast some times, so that's why I used aplay as well. Anybody have some m=
ore
> ideas how to tackle this problem or point me in the right direction so I =
can
> solve it myself? It seems I am so close to a working solution...
>
> Kind regards,
> Benjamin
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> __________ NOD32 3095 (20080513) Information __________
>
> This message was checked by NOD32 antivirus system.
> http://www.eset.com
>
>
>
>   =



-- =

Gustavo da Silva Serra        gustavo.serra@tet.com.br
=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=
=97=97
Tools & Technologies - T&T Engenheiros Associados Ltda.
Projetos de SW & HW - Desenvolvendo solu=E7=F5es.
Rua Riachuelo, 1098 Conj. 1204
Centro - Porto Alegre - CEP 90010-272
Fone DDR: (51)3220-3290
Fone/Fax: (51)3220-3220 / 3220-3206
http://www.tet.com.br/                                             tet@tet.=
com.br
