From: "James Courtier-Dutton" <james.dutton@gmail.com>
Subject: Re: default device setting doesn't work
Date: Wed, 19 Jul 2006 18:27:34 +0100
Message-ID: <ad2655cb0607191027t655e5ea3yf6e5fef8ccaa28f0@mail.gmail.com>
References: <715d90900607172251q7a94ac0bj752ae562da3f354d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <715d90900607172251q7a94ac0bj752ae562da3f354d@mail.gmail.com>
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
To: boku <boku0712@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 18/07/06, boku <boku0712@gmail.com> wrote:
> Dear all,
>     I met a problem that it doesn't work while I use the defaults
> device such as
>          aplay test.wav
>    I need to assign the -D so that the wav can be played such as
>          aplay -D hw:0,0   test.wav
>
> I didn't modify the .asoundrc or the alsa.conf. Anyone knows about this issue?
> Thank you~
>
> Best Regards,
>

Don't use hw:0,0
Use
aply -D plug:front:0  test.wav              (the 0 is the card number)

James

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
