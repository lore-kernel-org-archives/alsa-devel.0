From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Raise and lower volume through Alsa Api
Date: Fri, 26 May 2006 13:16:20 -0400
Message-ID: <1148663781.31038.69.camel@mindpipe>
References: <1147429541.26309.3.camel@jazc.fedora>
	<s5hpsijzbof.wl%tiwai@suse.de> <1147676786.2963.1.camel@jazc.fedora>
	<1147812562.13948.144.camel@mindpipe>	<m2psicldv8.fsf@vador2.mandriva.com>
	<1147892684.2473.0.camel@mindpipe>
	<1148631774.4785.2.camel@jazc.fedora>
	<4476BB92.3070203@purplelabs.com> <1148632283.4785.4.camel@jazc.fedora>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1148632283.4785.4.camel@jazc.fedora>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Juan Zapatero <jazc@gmvsistemas.es>
Cc: Benoit Fouet <benoit.fouet@purplelabs.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-05-26 at 10:31 +0200, Juan Zapatero wrote:
> But what about doing it through API, so that volume is set in the
> application, without using any volume plugin...

No, it's not currently possible with ALSA.  You have to implement your
own software volunme control.

Lee
