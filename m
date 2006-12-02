From: "James Courtier-Dutton" <james.dutton@gmail.com>
Subject: Re: Conexant CODEC Support In ALSA
Date: Sat, 2 Dec 2006 12:43:32 +0000
Message-ID: <ad2655cb0612020443v60a0766bue5e5d42fea9dacbd@mail.gmail.com>
References: <71F63FF0233C2545847A726F221A941955A982@nbmail4.nb.conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <71F63FF0233C2545847A726F221A941955A982@nbmail4.nb.conexant.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Eitan David <eitan.david@conexant.com>
Cc: Jonathan Chien <jonathan.chien@conexant.com>, alsa-devel@lists.sourceforge.net, Andrew Webster <andrew.webster@conexant.com>, Stephen McIntyre <steve.mcintyre@conexant.com>
List-Id: alsa-devel@alsa-project.org

On 01/12/06, Eitan David <eitan.david@conexant.com> wrote:
>
> All,
>
> We at Conexant are interested in getting our customers the best possible
> support for their Linux Audio when using our chipset. We would like to
> understand what it is going to be needed from us in order to make sure our
> latest HD Audio based CODEC is supported by ALSA. As HDA is more generic
> interface, basic audio support is already available.
>
> We would like to cooperate with ALSA and to supply the necessary
> documentation in order to make sure specific platform configurations are
> being supported. We do see today those specific features like Speakers to
> Headphones switching is not working properly on new system configurations.
>
> Please advice on the best way to proceed.
>
> Regards,
>
> Eitan David
>
> Director, PV Products Engineering
>
> Conexant Systems Inc.
>
> cnxtsmtp4.conexant.com made the following annotations
> ---------------------------------------------------------------------

Please make all appropriate documentation available on your web site,
and post a link to them on this list. We can then take a copy and add
it to our own datasheet stores at
ftp://ftp.alsa-project.org/pub/datasheets

We would generally need the datasheet for your chip, together with the
platform specific details, so as to save us having to reverse engineer
the platforms, because as you say, the HDA is a more generic
interface, with different platforms using it is different ways.

Then, anyone in the open source community is then able to add ALSA
support and fix ALSA bugs in order to support your chips and
platforms.

This approach is far more efficient that giving the datasheets to just
one developer.
We have a lack of ALSA developers currently, so having all the
necessary data up front saves a lot of time.

If you wish to add any priority with regard to what gets added first,
I suggest you provide some sort of sponsorship in the way of bounties
and donated hardware.

I develop support for Creative cards, and donations of hardware from
Creative have been particularly helpful there.

James

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
