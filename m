From: Frans Ketelaars <ketelaars@wanadoo.nl>
Subject: Re: shutting down alsa causes paging exception
Date: Wed, 27 Mar 2002 20:45:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020327204515.27d0e145.ketelaars@wanadoo.nl>
References: <m37knymr89.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <m37knymr89.fsf@ccs.covici.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: John Covici <covici@ccs.covici.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Mar 2002 01:58:46 -0500
John Covici <covici@ccs.covici.com> wrote:

> I am using the alsa which is integrated into the 2.5.7 kernel and I am
> getting unable to handle kernel paging whenever I try to shutdown the
> alsa drivers.  I have it as modules and I think it can't delete the
> module.  I can supply the log entries if that would help.
> 
> I am using the via8233 modules.
> 
> Any assistance would be appreciated.

I'm not a developer but I think you got a kernel oops, which you much 'decode'
with ksymoops to help. On my Mandrake 8.2 machine the info file is here 
(2.4.18 kernel): /usr/src/linux-2.4.18-6mdk/Documentation/oops-tracing.txt :)

    -Frans
