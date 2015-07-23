From: Clemens Lang <clemens.lang@bmw-carit.de>
Subject: [PATCH 1/2] Replace list.h with MIT-licensed
	implementation
Date: Thu, 23 Jul 2015 18:02:40 +0200
Message-ID: <1437667361-23152-2-git-send-email-clemens.lang@bmw-carit.de>
References: <20150119143100.GH4920@ulm-bmuc496424.bmw-carit.de>
 <1437667361-23152-1-git-send-email-clemens.lang@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bmw-carit.de (mail.bmw-carit.de [62.245.222.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B5512610B1
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 18:03:00 +0200 (CEST)
In-Reply-To: <1437667361-23152-1-git-send-email-clemens.lang@bmw-carit.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Clemens Lang <clemens.lang@bmw-carit.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The previous linked list implementation in include/list.h was taken from
Linux 2.4.0 and is thus likely licensed under GPL-2. If one does not
consider the implementation trivial and the license actually applies,
that might make libasound a derivative work, invoking the GPL's viral
effect. This would make libasound unusable for any program that is not
licensed under a GPL-compatible license.

Avoid any ambiguity in this regard by replacing the list with an
MIT-licensed implementation with similar API originally written by Rusty
Russell and adapted for alsa-libs. The original implementation is
available from
  http://ccodearchive.net/info/list.html

Since the implementation uses typeof() when available, adjust configure
to check for it.

See
  http://mailman.alsa-project.org/pipermail/alsa-devel/2014-December/085261.html
  http://mailman.alsa-project.org/pipermail/alsa-devel/2014-December/085262.html
  http://mailman.alsa-project.org/pipermail/alsa-devel/2014-December/085325.html
  http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/086754.html
for the discussion around this change.

Signed-off-by: Clemens Lang <clemens.lang@bmw-carit.de>
---
 configure.ac                |   1 +
 include/ccan_build_assert.h | 154 +++++++++++
 include/ccan_check_type.h   | 178 ++++++++++++
 include/ccan_container_of.h | 259 ++++++++++++++++++
 include/list.h              | 649 +++++++++++++++++++++++++++++++++++++-------
 5 files changed, 1138 insertions(+), 103 deletions(-)
 create mode 100644 include/ccan_build_assert.h
 create mode 100644 include/ccan_check_type.h
 create mode 100644 include/ccan_container_of.h

diff --git a/configure.ac b/configure.ac
index 9621d4e..be62b83 100644
--- a/configure.ac
+++ b/configure.ac
@@ -61,6 +61,7 @@ AC_CONFIG_HEADERS(include/config.h)
 dnl Checks for typedefs, structures, and compiler characteristics.
 AC_C_CONST
 AC_C_INLINE
+AC_C_TYPEOF
 AC_HEADER_TIME
 
 dnl Checks for library functions.
diff --git a/include/ccan_build_assert.h b/include/ccan_build_assert.h
new file mode 100644
index 0000000..56160a9
--- /dev/null
+++ b/include/ccan_build_assert.h
@@ -0,0 +1,154 @@
+/*
+ * Routines for build-time assertions
+ * Author: Rusty Russell <rusty@rustcorp.com.au>
+ * From http://ccodearchive.net/info/build_assert.html
+ * License: CC0 1.0 Universal (http://creativecommons.org/publicdomain/zero/1.0/legalcode)
+ */
+/*
+Statement of Purpose
+
+The laws of most jurisdictions throughout the world automatically confer
+exclusive Copyright and Related Rights (defined below) upon the creator and
+subsequent owner(s) (each and all, an "owner") of an original work of authorship
+and/or a database (each, a "Work").
+
+Certain owners wish to permanently relinquish those rights to a Work for the
+purpose of contributing to a commons of creative, cultural and scientific works
+("Commons") that the public can reliably and without fear of later claims of
+infringement build upon, modify, incorporate in other works, reuse and
+redistribute as freely as possible in any form whatsoever and for any purposes,
+including without limitation commercial purposes. These owners may contribute to
+the Commons to promote the ideal of a free culture and the further production of
+creative, cultural and scientific works, or to gain reputation or greater
+distribution for their Work in part through the use and efforts of others.
+
+For these and/or other purposes and motivations, and without any expectation of
+additional consideration or compensation, the person associating CC0 with a Work
+(the "Affirmer"), to the extent that he or she is an owner of Copyright and
+Related Rights in the Work, voluntarily elects to apply CC0 to the Work and
+publicly distribute the Work under its terms, with knowledge of his or her
+Copyright and Related Rights in the Work and the meaning and intended legal
+effect of CC0 on those rights.
+
+1. Copyright and Related Rights. A Work made available under CC0 may be
+   protected by copyright and related or neighboring rights ("Copyright and
+   Related Rights"). Copyright and Related Rights include, but are not limited
+   to, the following:
+
+     i. the right to reproduce, adapt, distribute, perform, display,
+        communicate, and translate a Work;
+    ii. moral rights retained by the original author(s) and/or performer(s);
+   iii. publicity and privacy rights pertaining to a person's image or likeness
+        depicted in a Work;
+    iv. rights protecting against unfair competition in regards to a Work,
+        subject to the limitations in paragraph 4(a), below;
+     v. rights protecting the extraction, dissemination, use and reuse of data
+        in a Work;
+    vi. database rights (such as those arising under Directive 96/9/EC of the
+        European Parliament and of the Council of 11 March 1996 on the legal
+        protection of databases, and under any national implementation thereof,
+        including any amended or successor version of such directive); and
+   vii. other similar, equivalent or corresponding rights throughout the world
+        based on applicable law or treaty, and any national implementations
+        thereof.
+
+2. Waiver. To the greatest extent permitted by, but not in contravention of,
+   applicable law, Affirmer hereby overtly, fully, permanently, irrevocably and
+   unconditionally waives, abandons, and surrenders all of Affirmer's Copyright
+   and Related Rights and associated claims and causes of action, whether now
+   known or unknown (including existing as well as future claims and causes of
+   action), in the Work (i) in all territories worldwide, (ii) for the maximum
+   duration provided by applicable law or treaty (including future time
+   extensions), (iii) in any current or future medium and for any number of
+   copies, and (iv) for any purpose whatsoever, including without limitation
+   commercial, advertising or promotional purposes (the "Waiver"). Affirmer
+   makes the Waiver for the benefit of each member of the public at large and to
+   the detriment of Affirmer's heirs and successors, fully intending that such
+   Waiver shall not be subject to revocation, rescission, cancellation,
+   termination, or any other legal or equitable action to disrupt the quiet
+   enjoyment of the Work by the public as contemplated by Affirmer's express
+   Statement of Purpose.
+
+3. Public License Fallback. Should any part of the Waiver for any reason be
+   judged legally invalid or ineffective under applicable law, then the Waiver
+   shall be preserved to the maximum extent permitted taking into account
+   Affirmer's express Statement of Purpose. In addition, to the extent the
+   Waiver is so judged Affirmer hereby grants to each affected person
+   a royalty-free, non transferable, non sublicensable, non exclusive,
+   irrevocable and unconditional license to exercise Affirmer's Copyright and
+   Related Rights in the Work (i) in all territories worldwide, (ii) for the
+   maximum duration provided by applicable law or treaty (including future time
+   extensions), (iii) in any current or future medium and for any number of
+   copies, and (iv) for any purpose whatsoever, including without limitation
+   commercial, advertising or promotional purposes (the "License"). The License
+   shall be deemed effective as of the date CC0 was applied by Affirmer to the
+   Work. Should any part of the License for any reason be judged legally invalid
+   or ineffective under applicable law, such partial invalidity or
+   ineffectiveness shall not invalidate the remainder of the License, and in
+   such case Affirmer hereby affirms that he or she will not (i) exercise any of
+   his or her remaining Copyright and Related Rights in the Work or (ii) assert
+   any associated claims and causes of action with respect to the Work, in
+   either case contrary to Affirmer's express Statement of Purpose.
+
+4. Limitations and Disclaimers.
+
+   a. No trademark or patent rights held by Affirmer are waived, abandoned,
+      surrendered, licensed or otherwise affected by this document.
+
+   b. Affirmer offers the Work as-is and makes no representations or warranties
+      of any kind concerning the Work, express, implied, statutory or otherwise,
+      including without limitation warranties of title, merchantability, fitness
+      for a particular purpose, non infringement, or the absence of latent or
+      other defects, accuracy, or the present or absence of errors, whether or
+      not discoverable, all to the greatest extent permissible under applicable
+      law.
+
+   c. Affirmer disclaims responsibility for clearing rights of other persons
+      that may apply to the Work or any use thereof, including without
+      limitation any person's Copyright and Related Rights in the Work. Further,
+      Affirmer disclaims responsibility for obtaining any necessary consents,
+      permissions or other rights required for any use of the Work.
+
+   d. Affirmer understands and acknowledges that Creative Commons is not a party
+      to this document and has no duty or obligation with respect to this CC0 or
+      use of the Work.
+*/
+#ifndef CCAN_BUILD_ASSERT_H
+#define CCAN_BUILD_ASSERT_H
+
+/**
+ * BUILD_ASSERT - assert a build-time dependency.
+ * @cond: the compile-time condition which must be true.
+ *
+ * Your compile will fail if the condition isn't true, or can't be evaluated
+ * by the compiler.  This can only be used within a function.
+ *
+ * Example:
+ *	#include <stddef.h>
+ *	...
+ *	static char *foo_to_char(struct foo *foo)
+ *	{
+ *		// This code needs string to be at start of foo.
+ *		BUILD_ASSERT(offsetof(struct foo, string) == 0);
+ *		return (char *)foo;
+ *	}
+ */
+#define BUILD_ASSERT(cond) \
+	do { (void) sizeof(char [1 - 2*!(cond)]); } while(0)
+
+/**
+ * BUILD_ASSERT_OR_ZERO - assert a build-time dependency, as an expression.
+ * @cond: the compile-time condition which must be true.
+ *
+ * Your compile will fail if the condition isn't true, or can't be evaluated
+ * by the compiler.  This can be used in an expression: its value is "0".
+ *
+ * Example:
+ *	#define foo_to_char(foo)					\
+ *		 ((char *)(foo)						\
+ *		  + BUILD_ASSERT_OR_ZERO(offsetof(struct foo, string) == 0))
+ */
+#define BUILD_ASSERT_OR_ZERO(cond) \
+	(sizeof(char [1 - 2*!(cond)]) - 1)
+
+#endif /* CCAN_BUILD_ASSERT_H */
diff --git a/include/ccan_check_type.h b/include/ccan_check_type.h
new file mode 100644
index 0000000..f957630
--- /dev/null
+++ b/include/ccan_check_type.h
@@ -0,0 +1,178 @@
+/*
+ * Routines for compile time type checking
+ * Author: Rusty Russell <rusty@rustcorp.com.au>
+ * From http://ccodearchive.net/info/check_type.html
+ * License: CC0 1.0 Universal (http://creativecommons.org/publicdomain/zero/1.0/legalcode)
+ */
+/*
+Statement of Purpose
+
+The laws of most jurisdictions throughout the world automatically confer
+exclusive Copyright and Related Rights (defined below) upon the creator and
+subsequent owner(s) (each and all, an "owner") of an original work of authorship
+and/or a database (each, a "Work").
+
+Certain owners wish to permanently relinquish those rights to a Work for the
+purpose of contributing to a commons of creative, cultural and scientific works
+("Commons") that the public can reliably and without fear of later claims of
+infringement build upon, modify, incorporate in other works, reuse and
+redistribute as freely as possible in any form whatsoever and for any purposes,
+including without limitation commercial purposes. These owners may contribute to
+the Commons to promote the ideal of a free culture and the further production of
+creative, cultural and scientific works, or to gain reputation or greater
+distribution for their Work in part through the use and efforts of others.
+
+For these and/or other purposes and motivations, and without any expectation of
+additional consideration or compensation, the person associating CC0 with a Work
+(the "Affirmer"), to the extent that he or she is an owner of Copyright and
+Related Rights in the Work, voluntarily elects to apply CC0 to the Work and
+publicly distribute the Work under its terms, with knowledge of his or her
+Copyright and Related Rights in the Work and the meaning and intended legal
+effect of CC0 on those rights.
+
+1. Copyright and Related Rights. A Work made available under CC0 may be
+   protected by copyright and related or neighboring rights ("Copyright and
+   Related Rights"). Copyright and Related Rights include, but are not limited
+   to, the following:
+
+     i. the right to reproduce, adapt, distribute, perform, display,
+        communicate, and translate a Work;
+    ii. moral rights retained by the original author(s) and/or performer(s);
+   iii. publicity and privacy rights pertaining to a person's image or likeness
+        depicted in a Work;
+    iv. rights protecting against unfair competition in regards to a Work,
+        subject to the limitations in paragraph 4(a), below;
+     v. rights protecting the extraction, dissemination, use and reuse of data
+        in a Work;
+    vi. database rights (such as those arising under Directive 96/9/EC of the
+        European Parliament and of the Council of 11 March 1996 on the legal
+        protection of databases, and under any national implementation thereof,
+        including any amended or successor version of such directive); and
+   vii. other similar, equivalent or corresponding rights throughout the world
+        based on applicable law or treaty, and any national implementations
+        thereof.
+
+2. Waiver. To the greatest extent permitted by, but not in contravention of,
+   applicable law, Affirmer hereby overtly, fully, permanently, irrevocably and
+   unconditionally waives, abandons, and surrenders all of Affirmer's Copyright
+   and Related Rights and associated claims and causes of action, whether now
+   known or unknown (including existing as well as future claims and causes of
+   action), in the Work (i) in all territories worldwide, (ii) for the maximum
+   duration provided by applicable law or treaty (including future time
+   extensions), (iii) in any current or future medium and for any number of
+   copies, and (iv) for any purpose whatsoever, including without limitation
+   commercial, advertising or promotional purposes (the "Waiver"). Affirmer
+   makes the Waiver for the benefit of each member of the public at large and to
+   the detriment of Affirmer's heirs and successors, fully intending that such
+   Waiver shall not be subject to revocation, rescission, cancellation,
+   termination, or any other legal or equitable action to disrupt the quiet
+   enjoyment of the Work by the public as contemplated by Affirmer's express
+   Statement of Purpose.
+
+3. Public License Fallback. Should any part of the Waiver for any reason be
+   judged legally invalid or ineffective under applicable law, then the Waiver
+   shall be preserved to the maximum extent permitted taking into account
+   Affirmer's express Statement of Purpose. In addition, to the extent the
+   Waiver is so judged Affirmer hereby grants to each affected person
+   a royalty-free, non transferable, non sublicensable, non exclusive,
+   irrevocable and unconditional license to exercise Affirmer's Copyright and
+   Related Rights in the Work (i) in all territories worldwide, (ii) for the
+   maximum duration provided by applicable law or treaty (including future time
+   extensions), (iii) in any current or future medium and for any number of
+   copies, and (iv) for any purpose whatsoever, including without limitation
+   commercial, advertising or promotional purposes (the "License"). The License
+   shall be deemed effective as of the date CC0 was applied by Affirmer to the
+   Work. Should any part of the License for any reason be judged legally invalid
+   or ineffective under applicable law, such partial invalidity or
+   ineffectiveness shall not invalidate the remainder of the License, and in
+   such case Affirmer hereby affirms that he or she will not (i) exercise any of
+   his or her remaining Copyright and Related Rights in the Work or (ii) assert
+   any associated claims and causes of action with respect to the Work, in
+   either case contrary to Affirmer's express Statement of Purpose.
+
+4. Limitations and Disclaimers.
+
+   a. No trademark or patent rights held by Affirmer are waived, abandoned,
+      surrendered, licensed or otherwise affected by this document.
+
+   b. Affirmer offers the Work as-is and makes no representations or warranties
+      of any kind concerning the Work, express, implied, statutory or otherwise,
+      including without limitation warranties of title, merchantability, fitness
+      for a particular purpose, non infringement, or the absence of latent or
+      other defects, accuracy, or the present or absence of errors, whether or
+      not discoverable, all to the greatest extent permissible under applicable
+      law.
+
+   c. Affirmer disclaims responsibility for clearing rights of other persons
+      that may apply to the Work or any use thereof, including without
+      limitation any person's Copyright and Related Rights in the Work. Further,
+      Affirmer disclaims responsibility for obtaining any necessary consents,
+      permissions or other rights required for any use of the Work.
+
+   d. Affirmer understands and acknowledges that Creative Commons is not a party
+      to this document and has no duty or obligation with respect to this CC0 or
+      use of the Work.
+*/
+#ifndef CCAN_CHECK_TYPE_H
+#define CCAN_CHECK_TYPE_H
+#include "config.h"
+
+/**
+ * check_type - issue a warning or build failure if type is not correct.
+ * @expr: the expression whose type we should check (not evaluated).
+ * @type: the exact type we expect the expression to be.
+ *
+ * This macro is usually used within other macros to try to ensure that a macro
+ * argument is of the expected type.  No type promotion of the expression is
+ * done: an unsigned int is not the same as an int!
+ *
+ * check_type() always evaluates to 0.
+ *
+ * If your compiler does not support typeof, then the best we can do is fail
+ * to compile if the sizes of the types are unequal (a less complete check).
+ *
+ * Example:
+ *	// They should always pass a 64-bit value to _set_some_value!
+ *	#define set_some_value(expr)			\
+ *		_set_some_value((check_type((expr), uint64_t), (expr)))
+ */
+
+/**
+ * check_types_match - issue a warning or build failure if types are not same.
+ * @expr1: the first expression (not evaluated).
+ * @expr2: the second expression (not evaluated).
+ *
+ * This macro is usually used within other macros to try to ensure that
+ * arguments are of identical types.  No type promotion of the expressions is
+ * done: an unsigned int is not the same as an int!
+ *
+ * check_types_match() always evaluates to 0.
+ *
+ * If your compiler does not support typeof, then the best we can do is fail
+ * to compile if the sizes of the types are unequal (a less complete check).
+ *
+ * Example:
+ *	// Do subtraction to get to enclosing type, but make sure that
+ *	// pointer is of correct type for that member.
+ *	#define container_of(mbr_ptr, encl_type, mbr)			\
+ *		(check_types_match((mbr_ptr), &((encl_type *)0)->mbr),	\
+ *		 ((encl_type *)						\
+ *		  ((char *)(mbr_ptr) - offsetof(enclosing_type, mbr))))
+ */
+#if HAVE_TYPEOF
+#define check_type(expr, type)			\
+	((typeof(expr) *)0 != (type *)0)
+
+#define check_types_match(expr1, expr2)		\
+	((typeof(expr1) *)0 != (typeof(expr2) *)0)
+#else
+#include <ccan_build_assert.h>
+/* Without typeof, we can only test the sizes. */
+#define check_type(expr, type)					\
+	BUILD_ASSERT_OR_ZERO(sizeof(expr) == sizeof(type))
+
+#define check_types_match(expr1, expr2)				\
+	BUILD_ASSERT_OR_ZERO(sizeof(expr1) == sizeof(expr2))
+#endif /* HAVE_TYPEOF */
+
+#endif /* CCAN_CHECK_TYPE_H */
diff --git a/include/ccan_container_of.h b/include/ccan_container_of.h
new file mode 100644
index 0000000..1d92fd9
--- /dev/null
+++ b/include/ccan_container_of.h
@@ -0,0 +1,259 @@
+/*
+ * Routine for upcasting
+ * Author: Rusty Russell <rusty@rustcorp.com.au>
+ * From http://ccodearchive.net/info/container_of.html
+ * License: CC0 1.0 Universal (http://creativecommons.org/publicdomain/zero/1.0/legalcode)
+ */
+/*
+Statement of Purpose
+
+The laws of most jurisdictions throughout the world automatically confer
+exclusive Copyright and Related Rights (defined below) upon the creator and
+subsequent owner(s) (each and all, an "owner") of an original work of authorship
+and/or a database (each, a "Work").
+
+Certain owners wish to permanently relinquish those rights to a Work for the
+purpose of contributing to a commons of creative, cultural and scientific works
+("Commons") that the public can reliably and without fear of later claims of
+infringement build upon, modify, incorporate in other works, reuse and
+redistribute as freely as possible in any form whatsoever and for any purposes,
+including without limitation commercial purposes. These owners may contribute to
+the Commons to promote the ideal of a free culture and the further production of
+creative, cultural and scientific works, or to gain reputation or greater
+distribution for their Work in part through the use and efforts of others.
+
+For these and/or other purposes and motivations, and without any expectation of
+additional consideration or compensation, the person associating CC0 with a Work
+(the "Affirmer"), to the extent that he or she is an owner of Copyright and
+Related Rights in the Work, voluntarily elects to apply CC0 to the Work and
+publicly distribute the Work under its terms, with knowledge of his or her
+Copyright and Related Rights in the Work and the meaning and intended legal
+effect of CC0 on those rights.
+
+1. Copyright and Related Rights. A Work made available under CC0 may be
+   protected by copyright and related or neighboring rights ("Copyright and
+   Related Rights"). Copyright and Related Rights include, but are not limited
+   to, the following:
+
+     i. the right to reproduce, adapt, distribute, perform, display,
+        communicate, and translate a Work;
+    ii. moral rights retained by the original author(s) and/or performer(s);
+   iii. publicity and privacy rights pertaining to a person's image or likeness
+        depicted in a Work;
+    iv. rights protecting against unfair competition in regards to a Work,
+        subject to the limitations in paragraph 4(a), below;
+     v. rights protecting the extraction, dissemination, use and reuse of data
+        in a Work;
+    vi. database rights (such as those arising under Directive 96/9/EC of the
+        European Parliament and of the Council of 11 March 1996 on the legal
+        protection of databases, and under any national implementation thereof,
+        including any amended or successor version of such directive); and
+   vii. other similar, equivalent or corresponding rights throughout the world
+        based on applicable law or treaty, and any national implementations
+        thereof.
+
+2. Waiver. To the greatest extent permitted by, but not in contravention of,
+   applicable law, Affirmer hereby overtly, fully, permanently, irrevocably and
+   unconditionally waives, abandons, and surrenders all of Affirmer's Copyright
+   and Related Rights and associated claims and causes of action, whether now
+   known or unknown (including existing as well as future claims and causes of
+   action), in the Work (i) in all territories worldwide, (ii) for the maximum
+   duration provided by applicable law or treaty (including future time
+   extensions), (iii) in any current or future medium and for any number of
+   copies, and (iv) for any purpose whatsoever, including without limitation
+   commercial, advertising or promotional purposes (the "Waiver"). Affirmer
+   makes the Waiver for the benefit of each member of the public at large and to
+   the detriment of Affirmer's heirs and successors, fully intending that such
+   Waiver shall not be subject to revocation, rescission, cancellation,
+   termination, or any other legal or equitable action to disrupt the quiet
+   enjoyment of the Work by the public as contemplated by Affirmer's express
+   Statement of Purpose.
+
+3. Public License Fallback. Should any part of the Waiver for any reason be
+   judged legally invalid or ineffective under applicable law, then the Waiver
+   shall be preserved to the maximum extent permitted taking into account
+   Affirmer's express Statement of Purpose. In addition, to the extent the
+   Waiver is so judged Affirmer hereby grants to each affected person
+   a royalty-free, non transferable, non sublicensable, non exclusive,
+   irrevocable and unconditional license to exercise Affirmer's Copyright and
+   Related Rights in the Work (i) in all territories worldwide, (ii) for the
+   maximum duration provided by applicable law or treaty (including future time
+   extensions), (iii) in any current or future medium and for any number of
+   copies, and (iv) for any purpose whatsoever, including without limitation
+   commercial, advertising or promotional purposes (the "License"). The License
+   shall be deemed effective as of the date CC0 was applied by Affirmer to the
+   Work. Should any part of the License for any reason be judged legally invalid
+   or ineffective under applicable law, such partial invalidity or
+   ineffectiveness shall not invalidate the remainder of the License, and in
+   such case Affirmer hereby affirms that he or she will not (i) exercise any of
+   his or her remaining Copyright and Related Rights in the Work or (ii) assert
+   any associated claims and causes of action with respect to the Work, in
+   either case contrary to Affirmer's express Statement of Purpose.
+
+4. Limitations and Disclaimers.
+
+   a. No trademark or patent rights held by Affirmer are waived, abandoned,
+      surrendered, licensed or otherwise affected by this document.
+
+   b. Affirmer offers the Work as-is and makes no representations or warranties
+      of any kind concerning the Work, express, implied, statutory or otherwise,
+      including without limitation warranties of title, merchantability, fitness
+      for a particular purpose, non infringement, or the absence of latent or
+      other defects, accuracy, or the present or absence of errors, whether or
+      not discoverable, all to the greatest extent permissible under applicable
+      law.
+
+   c. Affirmer disclaims responsibility for clearing rights of other persons
+      that may apply to the Work or any use thereof, including without
+      limitation any person's Copyright and Related Rights in the Work. Further,
+      Affirmer disclaims responsibility for obtaining any necessary consents,
+      permissions or other rights required for any use of the Work.
+
+   d. Affirmer understands and acknowledges that Creative Commons is not a party
+      to this document and has no duty or obligation with respect to this CC0 or
+      use of the Work.
+*/
+#ifndef CCAN_CONTAINER_OF_H
+#define CCAN_CONTAINER_OF_H
+#include <stddef.h>
+
+#include "config.h"
+#include <ccan_check_type.h>
+
+/**
+ * container_of - get pointer to enclosing structure
+ * @member_ptr: pointer to the structure member
+ * @containing_type: the type this member is within
+ * @member: the name of this member within the structure.
+ *
+ * Given a pointer to a member of a structure, this macro does pointer
+ * subtraction to return the pointer to the enclosing type.
+ *
+ * Example:
+ *	struct foo {
+ *		int fielda, fieldb;
+ *		// ...
+ *	};
+ *	struct info {
+ *		int some_other_field;
+ *		struct foo my_foo;
+ *	};
+ *
+ *	static struct info *foo_to_info(struct foo *foo)
+ *	{
+ *		return container_of(foo, struct info, my_foo);
+ *	}
+ */
+#define container_of(member_ptr, containing_type, member)		\
+	 ((containing_type *)						\
+	  ((char *)(member_ptr)						\
+	   - container_off(containing_type, member))			\
+	  + check_types_match(*(member_ptr), ((containing_type *)0)->member))
+
+
+/**
+ * container_of_or_null - get pointer to enclosing structure, or NULL
+ * @member_ptr: pointer to the structure member
+ * @containing_type: the type this member is within
+ * @member: the name of this member within the structure.
+ *
+ * Given a pointer to a member of a structure, this macro does pointer
+ * subtraction to return the pointer to the enclosing type, unless it
+ * is given NULL, in which case it also returns NULL.
+ *
+ * Example:
+ *	struct foo {
+ *		int fielda, fieldb;
+ *		// ...
+ *	};
+ *	struct info {
+ *		int some_other_field;
+ *		struct foo my_foo;
+ *	};
+ *
+ *	static struct info *foo_to_info_allowing_null(struct foo *foo)
+ *	{
+ *		return container_of_or_null(foo, struct info, my_foo);
+ *	}
+ */
+static inline char *container_of_or_null_(void *member_ptr, size_t offset)
+{
+	return member_ptr ? (char *)member_ptr - offset : NULL;
+}
+#define container_of_or_null(member_ptr, containing_type, member)	\
+	((containing_type *)						\
+	 container_of_or_null_(member_ptr,				\
+			       container_off(containing_type, member))	\
+	 + check_types_match(*(member_ptr), ((containing_type *)0)->member))
+
+/**
+ * container_off - get offset to enclosing structure
+ * @containing_type: the type this member is within
+ * @member: the name of this member within the structure.
+ *
+ * Given a pointer to a member of a structure, this macro does
+ * typechecking and figures out the offset to the enclosing type.
+ *
+ * Example:
+ *	struct foo {
+ *		int fielda, fieldb;
+ *		// ...
+ *	};
+ *	struct info {
+ *		int some_other_field;
+ *		struct foo my_foo;
+ *	};
+ *
+ *	static struct info *foo_to_info(struct foo *foo)
+ *	{
+ *		size_t off = container_off(struct info, my_foo);
+ *		return (void *)((char *)foo - off);
+ *	}
+ */
+#define container_off(containing_type, member)	\
+	offsetof(containing_type, member)
+
+/**
+ * container_of_var - get pointer to enclosing structure using a variable
+ * @member_ptr: pointer to the structure member
+ * @container_var: a pointer of same type as this member's container
+ * @member: the name of this member within the structure.
+ *
+ * Given a pointer to a member of a structure, this macro does pointer
+ * subtraction to return the pointer to the enclosing type.
+ *
+ * Example:
+ *	static struct info *foo_to_i(struct foo *foo)
+ *	{
+ *		struct info *i = container_of_var(foo, i, my_foo);
+ *		return i;
+ *	}
+ */
+#if HAVE_TYPEOF
+#define container_of_var(member_ptr, container_var, member) \
+	container_of(member_ptr, typeof(*container_var), member)
+#else
+#define container_of_var(member_ptr, container_var, member)	\
+	((void *)((char *)(member_ptr)	-			\
+		  container_off_var(container_var, member)))
+#endif
+
+/**
+ * container_off_var - get offset of a field in enclosing structure
+ * @container_var: a pointer to a container structure
+ * @member: the name of a member within the structure.
+ *
+ * Given (any) pointer to a structure and a its member name, this
+ * macro does pointer subtraction to return offset of member in a
+ * structure memory layout.
+ *
+ */
+#if HAVE_TYPEOF
+#define container_off_var(var, member)		\
+	container_off(typeof(*var), member)
+#else
+#define container_off_var(var, member)			\
+	((const char *)&(var)->member - (const char *)(var))
+#endif
+
+#endif /* CCAN_CONTAINER_OF_H */
diff --git a/include/list.h b/include/list.h
index 4d9895f..a322361 100644
--- a/include/list.h
+++ b/include/list.h
@@ -1,174 +1,617 @@
-#ifndef _LIST_H
-#define _LIST_H
-
 /*
- * This code was taken from the Linux 2.4.0 kernel. [jaroslav]
+ * Double linked list routines
+ * Author: Rusty Russell <rusty@rustcorp.com.au>
+ * From http://ccodearchive.net/info/list.html
+ * License: MIT
+ *
+ * Modified for use in alsa-libs by Clemens Lang <clemens.lang@bmw-carit.de>
  */
-
 /*
- * Simple doubly linked list implementation.
- *
- * Some of the internal functions ("__xxx") are useful when
- * manipulating whole lists rather than single entries, as
- * sometimes we already know the next/prev entries and we can
- * generate better code by using them directly rather than
- * using the generic single-entry routines.
+Permission is hereby granted, free of charge, to any person obtaining a copy of
+this software and associated documentation files (the "Software"), to deal in
+the Software without restriction, including without limitation the rights to
+use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
+the Software, and to permit persons to whom the Software is furnished to do so,
+subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in all
+copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
+FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
+COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
+IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+#ifndef CCAN_LIST_H
+#define CCAN_LIST_H
+#include <stdbool.h>
+#include <assert.h>
+#include <ccan_container_of.h>
+#include <ccan_check_type.h>
 
-#ifndef LIST_HEAD_IS_DEFINED
-struct list_head {
+/**
+ * struct list_head - an entry in a doubly-linked list
+ * @next: next entry (self if empty)
+ * @prev: previous entry (self if empty)
+ *
+ * This is used as an entry in and head of a linked list.
+ * Example:
+ *	struct child {
+ *		const char *name;
+ *		// Linked list of all us children.
+ *		struct list_head list;
+ *	};
+ */
+struct list_head
+{
 	struct list_head *next, *prev;
 };
-#endif
 
+/**
+ * LIST_HEAD_INIT - initializer for an empty list_head
+ * @name: the name of the list.
+ *
+ * Explicit initializer for an empty list.
+ *
+ * See also:
+ *	LIST_HEAD, list_head_init()
+ *
+ * Example:
+ *	static struct list_head my_list = LIST_HEAD_INIT(my_list);
+ */
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
+/**
+ * LIST_HEAD - define and initialize an empty list_head
+ * @name: the name of the list.
+ *
+ * The LIST_HEAD macro defines a list_head and initializes it to an empty
+ * list.  It can be prepended by "static" to define a static list_head.
+ *
+ * See also:
+ *	INIT_LIST_HEAD, list_head_init()
+ *
+ * Example:
+ *	static LIST_HEAD(my_global_list);
+ */
 #define LIST_HEAD(name) \
 	struct list_head name = LIST_HEAD_INIT(name)
 
-#define INIT_LIST_HEAD(ptr) do { \
-	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
-} while (0)
+/**
+ * list_head_init - initialize a list_head
+ * @h: the list_head to set to the empty list
+ *
+ * Example:
+ *	...
+ *	struct parent *parent = malloc(sizeof(*parent));
+ *
+ *	list_head_init(&parent->children);
+ *	parent->num_children = 0;
+ */
+static inline void list_head_init(struct list_head *h)
+{
+	h->next = h->prev = h;
+}
+#define INIT_LIST_HEAD(x) list_head_init(x)
 
-/*
- * Insert a new entry between two known consecutive entries. 
+/**
+ * list_add - add an entry at the start of a linked list.
+ * @h: the list_head to add the node to
+ * @n: the list_head to add to the list.
  *
- * This is only for internal list manipulation where we know
- * the prev/next entries already!
+ * The list node does not need to be initialized; it will be overwritten.
+ * Example:
+ *	struct child *child = malloc(sizeof(*child));
+ *
+ *	child->name = "marvin";
+ *	list_add(&parent->children, &child->list);
+ *	parent->num_children++;
  */
-static __inline__ void __list_add(struct list_head * _new,
-				  struct list_head * prev,
-				  struct list_head * next)
+static inline void list_add(struct list_head *h,
+			     struct list_head *n)
 {
-	next->prev = _new;
-	_new->next = next;
-	_new->prev = prev;
-	prev->next = _new;
+	n->next = h->next;
+	n->prev = h;
+	h->next->prev = n;
+	h->next = n;
 }
 
 /**
- * list_add - add a new entry
- * @new: new entry to be added
- * @head: list head to add it after
+ * list_add_tail - add an entry at the end of a linked list.
+ * @n: the list_head to add to the list.
+ * @h: the list_head to add the node to
  *
- * Insert a new entry after the specified head.
- * This is good for implementing stacks.
+ * The list node does not need to be initialized; it will be overwritten.
+ * Example:
+ *	list_add_tail(&child->list, &parent->children);
+ *	parent->num_children++;
  */
-static __inline__ void list_add(struct list_head *_new, struct list_head *head)
+static inline void list_add_tail(struct list_head *n,
+				  struct list_head *h)
 {
-	__list_add(_new, head, head->next);
+	n->next = h;
+	n->prev = h->prev;
+	h->prev->next = n;
+	h->prev = n;
 }
 
 /**
- * list_add_tail - add a new entry
- * @new: new entry to be added
- * @head: list head to add it before
+ * list_empty - is a list empty?
+ * @h: the list_head
+ *
+ * If the list is empty, returns true.
  *
- * Insert a new entry before the specified head.
- * This is useful for implementing queues.
+ * Example:
+ *	assert(list_empty(&parent->children) == (parent->num_children == 0));
  */
-static __inline__ void list_add_tail(struct list_head *_new, struct list_head *head)
+static inline bool list_empty(const struct list_head *h)
 {
-	__list_add(_new, head->prev, head);
+	return h->next == h;
 }
 
-/*
- * Delete a list entry by making the prev/next entries
- * point to each other.
+/**
+ * list_del - delete an entry from an (unknown) linked list.
+ * @n: the list_head to delete from the list.
  *
- * This is only for internal list manipulation where we know
- * the prev/next entries already!
+ * Note that this leaves @n in an undefined state; it can be added to
+ * another list, but not deleted again.
+ *
+ * See also:
+ *	list_del_from(), list_del_init()
+ *
+ * Example:
+ *	list_del(&child->list);
+ *	parent->num_children--;
  */
-static __inline__ void __list_del(struct list_head * prev,
-				  struct list_head * next)
+static inline void list_del(struct list_head *n)
 {
-	next->prev = prev;
-	prev->next = next;
+	n->next->prev = n->prev;
+	n->prev->next = n->next;
 }
 
 /**
- * list_del - deletes entry from list.
- * @entry: the element to delete from the list.
- * Note: list_empty on entry does not return true after this, the entry is in an undefined state.
+ * list_del_init - delete a node, and reset it so it can be deleted again.
+ * @n: the list_head to be deleted.
+ *
+ * list_del(@n) or list_del_init() again after this will be safe,
+ * which can be useful in some cases.
+ *
+ * See also:
+ *	list_del_from(), list_del()
+ *
+ * Example:
+ *	list_del_init(&child->list);
+ *	parent->num_children--;
  */
-static __inline__ void list_del(struct list_head *entry)
+static inline void list_del_init(struct list_head *n)
 {
-	__list_del(entry->prev, entry->next);
+	list_del(n);
+	list_head_init(n);
 }
 
 /**
- * list_del_init - deletes entry from list and reinitialize it.
- * @entry: the element to delete from the list.n 
+ * list_del_from - delete an entry from a known linked list.
+ * @h: the list_head the node is in.
+ * @n: the list_head to delete from the list.
+ *
+ * This explicitly indicates which list a node is expected to be in,
+ * which is better documentation and can catch more bugs.
+ *
+ * See also: list_del()
+ *
+ * Example:
+ *	list_del_from(&parent->children, &child->list);
+ *	parent->num_children--;
  */
-static __inline__ void list_del_init(struct list_head *entry)
+static inline void list_del_from(struct list_head *h, struct list_head *n)
 {
-	__list_del(entry->prev, entry->next);
-	INIT_LIST_HEAD(entry); 
+	/* Quick test that catches a surprising number of bugs. */
+	assert(!list_empty(h));
+	list_del(n);
 }
 
 /**
- * list_empty - tests whether a list is empty
- * @head: the list to test.
+ * list_entry - convert a list_head back into the structure containing it.
+ * @n: the list_head
+ * @type: the type of the entry
+ * @member: the list_head member of the type
+ *
+ * Example:
+ *	// First list entry is children.next; convert back to child.
+ *	child = list_entry(parent->children.next, struct child, list);
+ *
+ * See Also:
+ *	list_top(), list_for_each()
+ */
+#define list_entry(n, type, member) container_of(n, type, member)
+
+/**
+ * list_top - get the first entry in a list
+ * @h: the list_head
+ * @type: the type of the entry
+ * @member: the list_head member of the type
+ *
+ * If the list is empty, returns NULL.
+ *
+ * Example:
+ *	struct child *first;
+ *	first = list_top(&parent->children, struct child, list);
+ *	if (!first)
+ *		printf("Empty list!\n");
  */
-static __inline__ int list_empty(struct list_head *head)
+#define list_top(h, type, member)					\
+	((type *)list_top_((h), list_off_(type, member)))
+
+static inline const void *list_top_(const struct list_head *h, size_t off)
 {
-	return head->next == head;
+	if (list_empty(h))
+		return NULL;
+	return (const char *)h->next - off;
 }
 
 /**
- * list_splice - join two lists
- * @list: the new list to add.
- * @head: the place to add it in the first list.
+ * list_pop - remove the first entry in a list
+ * @h: the list_head
+ * @type: the type of the entry
+ * @member: the list_head member of the type
+ *
+ * If the list is empty, returns NULL.
+ *
+ * Example:
+ *	struct child *one;
+ *	one = list_pop(&parent->children, struct child, list);
+ *	if (!one)
+ *		printf("Empty list!\n");
  */
-static __inline__ void list_splice(struct list_head *list, struct list_head *head)
+#define list_pop(h, type, member)					\
+	((type *)list_pop_((h), list_off_(type, member)))
+
+static inline const void *list_pop_(const struct list_head *h, size_t off)
 {
-	struct list_head *first = list->next;
+	struct list_head *n;
 
-	if (first != list) {
-		struct list_head *last = list->prev;
-		struct list_head *at = head->next;
+	if (list_empty(h))
+		return NULL;
+	n = h->next;
+	list_del(n);
+	return (const char *)n - off;
+}
 
-		first->prev = head;
-		head->next = first;
+/**
+ * list_tail - get the last entry in a list
+ * @h: the list_head
+ * @type: the type of the entry
+ * @member: the list_head member of the type
+ *
+ * If the list is empty, returns NULL.
+ *
+ * Example:
+ *	struct child *last;
+ *	last = list_tail(&parent->children, struct child, list);
+ *	if (!last)
+ *		printf("Empty list!\n");
+ */
+#define list_tail(h, type, member) \
+	((type *)list_tail_((h), list_off_(type, member)))
 
-		last->next = at;
-		at->prev = last;
-	}
+static inline const void *list_tail_(const struct list_head *h, size_t off)
+{
+	if (list_empty(h))
+		return NULL;
+	return (const char *)h->prev - off;
 }
 
 /**
- * list_for_each	-	iterate over a list
- * @pos:	the &struct list_head to use as a loop counter.
- * @head:	the head for your list.
+ * list_for_each - iterate through a list.
+ * @h: the list_head (warning: evaluated multiple times!)
+ * @i: the structure containing the list_head
+ * @member: the list_head member of the structure
+ *
+ * This is a convenient wrapper to iterate @i over the entire list.  It's
+ * a for loop, so you can break and continue as normal.
+ *
+ * Example:
+ *	list_for_each(&parent->children, child, list)
+ *		printf("Name: %s\n", child->name);
+ */
+#define list_for_each(h, i, member)					\
+	list_for_each_off(h, i, list_off_var_(i, member))
+
+/**
+ * list_for_each_raw - iterate through a list and return the list node struct
+ * rather than the list element.
+ * @h: the list_head (warning: evaluated multiple times!)
+ * @i: the structure containing the list_head
+ *
+ * This is a convenient wrapper to iterate @i over the entire list.  It's
+ * a for loop, so you can break and continue as normal.
+ *
+ * Example:
+ *	struct list_head *node;
+ *	list_for_each_raw(&parent->children, node) {
+ *		struct child *child = list_entry(node, struct child, list);
+ *		printf("Name: %s\n", child->name);
+ *	}
+ */
+#define list_for_each_raw(h, i)						\
+	for (i = (h)->next; i != (h); i = (h)->next)
+
+/**
+ * list_for_each_rev - iterate through a list backwards.
+ * @h: the list_head
+ * @i: the structure containing the list_head
+ * @member: the list_head member of the structure
+ *
+ * This is a convenient wrapper to iterate @i over the entire list.  It's
+ * a for loop, so you can break and continue as normal.
+ *
+ * Example:
+ *	list_for_each_rev(&parent->children, child, list)
+ *		printf("Name: %s\n", child->name);
  */
-#define list_for_each(pos, head) \
-	for (pos = (head)->next ; pos != (head); pos = pos->next)
+#define list_for_each_rev(h, i, member)					\
+	for (i = container_of_var((h)->prev, i, member);		\
+	     &i->member != (h);					\
+	     i = container_of_var(i->member.prev, i, member))
 
 /**
- * list_for_each_safe	-	iterate over a list safely (actual pointer can be invalidated)
- * @pos:	the &struct list_head to use as a loop counter.
- * @next:	the &struct list_head to use to save next.
- * @head:	the head for your list.
+ * list_for_each_safe - iterate through a list, maybe during deletion
+ * @h: the list_head
+ * @i: the structure containing the list_head
+ * @nxt: the structure containing the list_head
+ * @member: the list_head member of the structure
+ *
+ * This is a convenient wrapper to iterate @i over the entire list.  It's
+ * a for loop, so you can break and continue as normal.  The extra variable
+ * @nxt is used to hold the next element, so you can delete @i from the list.
+ *
+ * Example:
+ *	struct child *next;
+ *	list_for_each_safe(&parent->children, child, next, list) {
+ *		list_del(&child->list);
+ *		parent->num_children--;
+ *	}
  */
-#define list_for_each_safe(pos, npos, head) \
-	for (pos = (head)->next, npos = pos->next ; pos != (head); pos = npos, npos = pos->next)
+#define list_for_each_safe(h, i, nxt, member)				\
+	list_for_each_safe_off(h, i, nxt, list_off_var_(i, member))
 
 /**
- * list_entry - get the struct for this entry
- * @ptr:	the &struct list_head pointer.
- * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_struct within the struct.
+ * list_for_each_raw_safe - iterate through a list, maybe during deletion, and
+ * return the list node struct rather than the list element.
+ * @h: the list_head
+ * @i: the structure containing the list_head
+ * @nxt: the structure containing the list_head
+ *
+ * This is a convenient wrapper to iterate @i over the entire list.  It's
+ * a for loop, so you can break and continue as normal.  The extra variable
+ * @nxt is used to hold the next element, so you can delete @i from the list.
+ *
+ * Example:
+ *	struct list_head *node;
+ *	struct list_head *next;
+ *	list_for_each_raw_safe(&parent->children, node, next) {
+ *		struct child *child = list_entry(node, struct child, list);
+ *		printf("deleting Name: %s\n", child->name);
+ *		list_del(node);
+ *	}
  */
-#define list_entry(ptr, type, member) \
-	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+#define list_for_each_raw_safe(h, i, nxt)				\
+	for (i = (h)->next, nxt = i->next;				\
+	     i != (h); i = nxt, nxt = i->next)
 
 /**
- * list_entry - get the struct for this entry
- * @ptr:	the &struct list_head pointer.
- * @type:	the type of the struct this is embedded in.
- * @offset:	offset of entry inside a struct
+ * list_next - get the next entry in a list
+ * @h: the list_head
+ * @i: a pointer to an entry in the list.
+ * @member: the list_head member of the structure
+ *
+ * If @i was the last entry in the list, returns NULL.
+ *
+ * Example:
+ *	struct child *second;
+ *	second = list_next(&parent->children, first, list);
+ *	if (!second)
+ *		printf("No second child!\n");
+ */
+#define list_next(h, i, member)						\
+	((list_typeof(i))list_entry_or_null(h,				\
+					    (i)->member.next,		\
+					    list_off_var_((i), member)))
+
+/**
+ * list_prev - get the previous entry in a list
+ * @h: the list_head
+ * @i: a pointer to an entry in the list.
+ * @member: the list_head member of the structure
+ *
+ * If @i was the first entry in the list, returns NULL.
+ *
+ * Example:
+ *	first = list_prev(&parent->children, second, list);
+ *	if (!first)
+ *		printf("Can't go back to first child?!\n");
  */
-#define list_entry_offset(ptr, type, offset) \
-	((type *)((char *)(ptr)-(offset)))
+#define list_prev(h, i, member)						\
+	((list_typeof(i))list_entry_or_null(h,				\
+					    (i)->member.prev,		\
+					    list_off_var_((i), member)))
+
+/**
+ * list_append_list - empty one list onto the end of another.
+ * @to: the list to append into
+ * @from: the list to empty.
+ *
+ * This takes the entire contents of @from and moves it to the end of
+ * @to.  After this @from will be empty.
+ *
+ * Example:
+ *	struct list_head adopter;
+ *
+ *	list_append_list(&adopter, &parent->children);
+ *	assert(list_empty(&parent->children));
+ *	parent->num_children = 0;
+ */
+static inline void list_append_list_(struct list_head *to,
+				     struct list_head *from)
+{
+	struct list_head *from_tail = from->prev;
+	struct list_head *to_tail = to->prev;
+
+	/* Sew in head and entire list. */
+	to->prev = from_tail;
+	from_tail->next = to;
+	to_tail->next = from;
+	from->prev = to_tail;
+
+	/* Now remove head. */
+	list_del(from);
+	list_head_init(from);
+}
+
+/**
+ * list_prepend_list - empty one list into the start of another.
+ * @to: the list to prepend into
+ * @from: the list to empty.
+ *
+ * This takes the entire contents of @from and moves it to the start
+ * of @to.  After this @from will be empty.
+ *
+ * Example:
+ *	list_prepend_list(&adopter, &parent->children);
+ *	assert(list_empty(&parent->children));
+ *	parent->num_children = 0;
+ */
+static inline void list_prepend_list_(struct list_head *to,
+				      struct list_head *from)
+{
+	struct list_head *from_tail = from->prev;
+	struct list_head *to_head = to->next;
+
+	/* Sew in head and entire list. */
+	to->next = from;
+	from->prev = to;
+	to_head->prev = from_tail;
+	from_tail->next = to_head;
 
-#endif /* _LIST_H */
+	/* Now remove head. */
+	list_del(from);
+	list_head_init(from);
+}
+
+/**
+ * list_for_each_off - iterate through a list of memory regions.
+ * @h: the list_head
+ * @i: the pointer to a memory region wich contains list node data.
+ * @off: offset(relative to @i) at which list node data resides.
+ *
+ * This is a low-level wrapper to iterate @i over the entire list, used to
+ * implement all oher, more high-level, for-each constructs. It's a for loop,
+ * so you can break and continue as normal.
+ *
+ * WARNING! Being the low-level macro that it is, this wrapper doesn't know
+ * nor care about the type of @i. The only assumtion made is that @i points
+ * to a chunk of memory that at some @offset, relative to @i, contains a
+ * properly filled `struct node_list' which in turn contains pointers to
+ * memory chunks and it's turtles all the way down. Whith all that in mind
+ * remember that given the wrong pointer/offset couple this macro will
+ * happilly churn all you memory untill SEGFAULT stops it, in other words
+ * caveat emptor.
+ *
+ * It is worth mentioning that one of legitimate use-cases for that wrapper
+ * is operation on opaque types with known offset for `struct list_head'
+ * member(preferably 0), because it allows you not to disclose the type of
+ * @i.
+ *
+ * Example:
+ *	list_for_each_off(&parent->children, child,
+ *				offsetof(struct child, list))
+ *		printf("Name: %s\n", child->name);
+ */
+#define list_for_each_off(h, i, off)                                    \
+    for (i = list_node_to_off_((h)->next, (off));                         \
+       list_node_from_off_((void *)i, (off)) != (h);                      \
+       i = list_node_to_off_(list_node_from_off_((void *)i, (off))->next, \
+                             (off)))
+
+/**
+ * list_for_each_safe_off - iterate through a list of memory regions, maybe
+ * during deletion
+ * @h: the list_head
+ * @i: the pointer to a memory region wich contains list node data.
+ * @nxt: the structure containing the list_head
+ * @off: offset(relative to @i) at which list node data resides.
+ *
+ * For details see `list_for_each_off' and `list_for_each_safe'
+ * descriptions.
+ *
+ * Example:
+ *	list_for_each_safe_off(&parent->children, child,
+ *		next, offsetof(struct child, list))
+ *		printf("Name: %s\n", child->name);
+ */
+#define list_for_each_safe_off(h, i, nxt, off)                          \
+	for (i = list_node_to_off_((h)->next, (off)),			\
+         nxt = list_node_to_off_(list_node_from_off_(i, (off))->next,   \
+                                 (off));                                \
+       list_node_from_off_(i, (off)) != (h);                            \
+       i = nxt,                                                         \
+         nxt = list_node_to_off_(list_node_from_off_(i, (off))->next,   \
+                                 (off)))
+
+
+/* Other -off variants. */
+#define list_entry_off(n, type, off)		\
+	((type *)list_node_from_off_((n), (off)))
+
+#define list_head_off(h, type, off)		\
+	((type *)list_head_off((h), (off)))
+
+#define list_tail_off(h, type, off)		\
+	((type *)list_tail_((h), (off)))
+
+#define list_add_off(h, n, off)                 \
+	list_add((h), list_node_from_off_((n), (off)))
+
+#define list_del_off(n, off)                    \
+	list_del(list_node_from_off_((n), (off)))
+
+#define list_del_from_off(h, n, off)			\
+	list_del_from(h, list_node_from_off_((n), (off)))
+
+/* Offset helper functions so we only single-evaluate. */
+static inline void *list_node_to_off_(struct list_head *node, size_t off)
+{
+	return (void *)((char *)node - off);
+}
+static inline struct list_head *list_node_from_off_(void *ptr, size_t off)
+{
+	return (struct list_head *)((char *)ptr + off);
+}
+
+/* Get the offset of the member, but make sure it's a list_head. */
+#define list_off_(type, member)					\
+	(container_off(type, member) +				\
+	 check_type(((type *)0)->member, struct list_head))
+
+#define list_off_var_(var, member)			\
+	(container_off_var(var, member) +		\
+	 check_type(var->member, struct list_head))
+
+#if HAVE_TYPEOF
+#define list_typeof(var) typeof(var)
+#else
+#define list_typeof(var) void *
+#endif
+
+/* Returns member, or NULL if at end of list. */
+static inline void *list_entry_or_null(const struct list_head *h,
+				       const struct list_head *n,
+				       size_t off)
+{
+	if (n == h)
+		return NULL;
+	return (char *)n - off;
+}
+#endif /* CCAN_LIST_H */
-- 
2.1.0
