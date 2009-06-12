From: Robert Schweikert <rschweikert@novell.com>
Subject: LSB inclusion of ALSA
Date: Fri, 12 Jun 2009 13:56:32 -0400
Message-ID: <4A3296D0.4080701@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from victor.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C7101037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Jun 2009 19:56:50 +0200 (CEST)
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

Hi,

Currently ALSA is a trial use module for LSB
(http://www.linuxfoundation.org/collaborate/workgroups/lsb) 4.0 and it
is the intention to make ALSA mandatory with the LSB 4.1 release
targeted for Q1 2010. One of the requirements of a mandatory module is
the existence of a test suite for the module that covers a good chunk of
the interfaces provided by the LSB spec. An initial exploratory look at
the existing test cases showed that tests appear to be tied to hardware
drivers and are interactive.

Is this initial impression correct?

>From an LSB testing perspective, interface testing is  very important;
i.e. I call the interface with the arguments required and I get the
expected result back. Further the tests need to run in an automated
fashion and produce a certain output (automated processing). The output
can be created by retrofitting existing tests or by specifically writing
tests within the LSB test framework.

IMHO it would be best to have tests that are useful to both, the project
and the LSB and in a best case scenario we wouldn't have to start over
as the existing tests already cover a good part of the interface.

With this as background there are a few questions that have been raised
while discussing this during LSB workgroup sessions.

1.) Is there interest from the community side to participate in this
effort and accept patches?
2.) Is it reasonable to expect that the existing tests can be used in
some way by using a dummy sound device or a sound loop device to verify
output?
One requirement for LSB testing is that a test has only two states, pass
or fail, and a recovery or try again mode is not supported. Further a
test must pass or fail.
3.) Would the community be more comfortable if this is an effort that
creates new tests separate from the existing HW focused tests?
4.) Is anyone interested in helping with this effort, writing tests,
answering questions about ALSA for those not familiar with the interface
and or sound in general?

Comments, thoughts, etc. are much appreciated.

Thanks,
Robert

-- 
Robert Schweikert                           MAY THE SOURCE BE WITH YOU
Software Engineer Consultant                          LINUX
rschweikert@novell.com 
781-464-8147

Novell
Making IT Work As One
