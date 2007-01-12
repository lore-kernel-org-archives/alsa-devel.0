From: =?ISO-8859-1?Q?Ingo_M=FCller?= <alsa@ingomueller.net>
Subject: Re: Ideas for the softvol plugin
Date: Fri, 12 Jan 2007 17:11:58 +0100
Message-ID: <45A7B34E.8070908@ingomueller.net>
References: <70a871c80701092048v23fbf0d8yc40d434eab023506@mail.gmail.com>	<70a871c80701101406y3f8293e9sd57b1d4c5ba9b166@mail.gmail.com>	<45A64FBF.5070503@ingomueller.net>
	<20070111180318.2d56559a@zooty>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070111180318.2d56559a@zooty>
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

Hi!

It's just a blind guess, but *maybe* it could work with ladspa. There is
a ladspa plugin for alsa and a normalization plugin for ladspa. I didn't
work with either of them but it *could* work. If you really try it and
get it to work, then please add an howto in the ALSA wiki at
http://alsa.opensrc.org. I'd sure appriciate it!

Greets, Ingo


Tom Horsley schrieb:
> On Thu, 11 Jan 2007 15:54:55 +0100
> Ingo M=FCller <alsa@ingomueller.net> wrote:
> =

>> I have some ideas about features that could be added to the softvol
>> plugin, that I want to discuss with you.
> =

> The feature I'd love to see might possibly be called something like
> "dynamic volume normalizer". I want a central place to arrange for
> the volume to automagically go down when it starts getting loud
> and up when it starts getting soft. No two programs ever seem to
> treat volume settings the same so when one is working fine, the next
> one I start will blow my head off or be totally inaudible.
> =

> Would this softvol plugin be the place to figure out how to do that?
> Or is the architecture such that something entirely different would be
> required?


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
