From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] MIPS/sound: DB1200 audio support depends
	on MIPS arch.
Date: Thu, 10 Nov 2011 12:46:16 +0100
Message-ID: <CAOLZvyFYH7s4NJwKTvr-_WrS6kLKBZvgH8ZOi07EUgcZ-U-PHg__42248.6384552487$1320925648$gmane$org@mail.gmail.com>
References: <20111110122241.eed1e785e4c015a51b9ef585@canb.auug.org.au>
	<1320924059-4142-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1320924059-4142-1-git-send-email-manuel.lauss@googlemail.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Manuel Lauss <manuel.lauss@googlemail.com>, linux-next@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 10, 2011 at 12:20 PM, Manuel Lauss
<manuel.lauss@googlemail.com> wrote:
> DB1200 audio support should only be visible if MIPS/Alchemy arch is
> selected. =A0Fixes an x86-allmodconfig build failure in linux-next.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

Please ignore this one.  This is caused by  a stray change in on the
Alchemy patches
for 3.3.   I'll send a fix to Ralf asap.

Manuel
