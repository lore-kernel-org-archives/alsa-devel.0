From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: softvol plugin question
Date: Wed, 07 May 2008 14:17:46 -0300
Message-ID: <4821E43A.5050402@tet.com.br>
References: <4821AFFA.7010401@carallon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail4.tet.com.br [201.47.194.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EBA5243ED
	for <alsa-devel@alsa-project.org>;
	Wed,  7 May 2008 19:17:55 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id 4C32312000E
	for <alsa-devel@alsa-project.org>;
	Wed,  7 May 2008 14:17:52 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id 47724120008
	for <alsa-devel@alsa-project.org>;
	Wed,  7 May 2008 14:17:49 -0300 (BRST)
In-Reply-To: <4821AFFA.7010401@carallon.com>
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

I had this problem with alsamixer itself. It doesn't appear until I call =

"alsactl restore". To automate I added this line to /etc/rc.local.

Will Wagner escreveu:
> Hi,
>
> I have successfully set up alsa for my custom hardware and am using =

> sofvol plugin to do volume control as my hardware does not support it.
>
> The problem I am having is that the softvol control does not appear to =

> amixer until I have first used the softvol plugin with aplay. Is there a =

> simple way of 'loading' the softvol plugin at startup so that the =

> control gets created immediately?
>
> Thanks,
>
> Will.
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
