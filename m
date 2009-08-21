From: "Philip A. Prindeville" <philipp_subx@redfish-solutions.com>
Subject: Making only some targets on cross-compilation
Date: Thu, 20 Aug 2009 17:49:35 -0700
Message-ID: <4A8DEF1F.5000205@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com
	[66.232.79.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 4998F103886
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Aug 2009 02:49:47 +0200 (CEST)
Received: from [192.168.10.7] (builder.redfish-solutions.com [192.168.10.7])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.14.2/8.14.2) with ESMTP id
	n7L0nZZM006761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2009 18:49:43 -0600
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

Hi.

I'm working on the astlinux project (www.astlinux.org) and had a
question about doing a build for only a subset of the $SUBDIRS targets.

I tried doing something like:

make -C $(ALSA-LIB_DIR) \
  SUBDIRS='src include modules aserver'



but this fails. The problem is that if we look into the environment in
the top-level $(RECURSIVE_TARGETS): we get:

SUBDIRS=include src modules aserver
...
MAKEFLAGS=w --jobserver-fds=3,4 -j -- SUBDIRS=include\ src\ modules\ aserver CC=/home/philipp/asterisk/build_i586/staging_dir/bin/i586-linux-uclibc-gcc



so those targets eventually get picked up by the make running in
include/, which then overrides his own Makefile value:

SUBDIRS = sound


and tries to build the same top-level targets now in include/. Clearly
this is wrong.

Anyone have a work-around to this?  We're on an embedded system, and
don't want to build (nor install, obviously) "doc", "test", "alsalisp",
"utils", etc.

Having something like:

SUBDIRS=$(filter-out $(SUBDIRS_EXCLUDE),$(SUBDIRS))

would be really sweet.  Then I could just build as:

make -C $(ALSA-LIB_DIR) \
    all SUBDIRS_EXCLUDE='doc test utils'

and only get the targets I want...

Thanks,

-Philip
