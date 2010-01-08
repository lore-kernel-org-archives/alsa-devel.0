From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: audio surveilance
Date: Fri, 8 Jan 2010 15:58:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001081546130.4210@eeebox2.perex-int.cz>
References: <1262404487.4427.7.camel@sauterws02.sauterhome>
	<1262889015.28819.6.camel@sauterws02.sauterhome>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1262889015.28819.6.camel@sauterws02.sauterhome>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Sauter <John_Sauter@systemeyescomputerstore.com>
Cc: devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 7 Jan 2010, John Sauter wrote:

> Mr. Kysela,
>
> I have some patches to aplay to make it more useful for audio
> surveillance.  I have submitted the patches to the devel mailing list
> for comment here:
> <http://mailman.alsa-project.org/pipermail/alsa-devel/2010-January/024278.html>.
>
> I have received no negative comments, so I would like to propose these
> patches for inclusion in mainline.  What is the procedure for submitting
> patches for alsa-util?

Could you, please, a bit clean up your patch?

- There are a lot of "if (pidfile_written) remove (pidfile_name)" lines.
   It would be better  to create another function like prg_exit() and add
   this code there.

- Many C expressions are not splitted to more lines:
   "if (max_file_size && (rest > max_file_size)) rest = max_file_size;"

- Check all conditions. Use && and || operators instead bit-like AND (&)
   and OR (|). Like "if (filecount | use_strftime) {" etc.

- I would also appreciate, if you can split '--process-id-file' code
   changes and rest of implementation to two standalone patches for more
   easier review. Also, your patch contains some "space/tab replacements" -
   it might be moved to another patch too.

 					Thanks,
 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
