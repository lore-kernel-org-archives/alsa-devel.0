From: "James Courtier-Dutton" <james.dutton@gmail.com>
Subject: Re: Opening another audio driver from a driver
Date: Tue, 9 Jan 2007 16:20:44 +1100
Message-ID: <ad2655cb0701082120v7e85f4bftd635145c358d9371@mail.gmail.com>
References: <45A3132B.8070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45A3132B.8070608@gmail.com>
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
To: Himanshu Chauhan <hs.chauhan@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 09/01/07, Himanshu Chauhan <hs.chauhan@gmail.com> wrote:
> Hello all,
>
> I am working with the virtual device driver (dummy.c). Is it possible to
> route the audio data
> from the dummy driver to an actual hardware's device driver? For this,
> do I need to open the
> driver using syscalls? I don't want to make any changes on the other
> driver. I didn't see
> any exported functions in any of the actual drivers, so I cannot stack
> my driver on that.
>
> What should be done in this case?
>
> Thanks
>
> Regards
> --Himanshu
>

I don't think you can do that. I also don't see why you would want to do it.
If you want to like the dummy one to the real one, why use the dummy
one in the first place. Just use the real one.

James

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
